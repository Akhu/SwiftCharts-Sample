//
//  ContentView.swift
//  ChartsSample-1
//
//  Created by Anthony Da cruz on 26/09/2022.
//

import SwiftUI
import Charts


struct ContentView: View {
    @State var dataLocalization = [DataPerLocalization]()
    @State var dataType = [DataPerType]()
    @State var dataYear = [DataPerYear]()
    
    @State private var showAverageOccurence = true

    func averageOccurences() -> Float {
        var totalCount = 0
        dataType.forEach { element in
            totalCount += element.occurences
        }

        return Float(totalCount / dataType.count)
    }
    var body: some View {
        NavigationStack {
            List {
                Section("Nombre d'infractions depuis 2016") {
                    Chart {
                        ForEach(dataYear) { set in
                            BarMark(x: .value("Année", set.year),
                                     y: .value("Occurence", set.occurences)
                            )
                            .opacity(0.3)

                            LineMark(x: .value("Année", set.year),
                                      y: .value("Occurence", set.occurences)
                            )
                            .interpolationMethod(.catmullRom(alpha: 0.2))
                            PointMark(x: .value("Année", set.year),
                                      y: .value("Occurence", set.occurences)
                            )
                        }
                    }
                    .frame(height: 200)
                    .chartYAxis {
                        AxisMarks(values: .stride(by: Float(1000000))) { value in
                            AxisGridLine().foregroundStyle(Color.black.opacity(0.1))
                            AxisValueLabel(format: Decimal.FormatStyle.number)
                        }
                    }
                }
                Section("Nombre d'infractions depuis 2016 par département") {
                    Chart {
                        ForEach(dataLocalization) { set in
                            BarMark(x: .value("Département", set.dept),
                                     y: .value("Occurence", set.occurences)
                            ).cornerRadius(5)
                            
                        }
                    }
                    .foregroundStyle(LinearGradient(colors: [.red.opacity(0.3), .red], startPoint: .bottom, endPoint: .top))
                    .frame(height: 200)
                }
                Section("Répartition des infraction depuis 2016") {
                    VStack(spacing: 24) {
                        Button {
                            showAverageOccurence.toggle()
                        } label: {
                            Text("Afficher la moyenne des infractions")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(showAverageOccurence ? .mint : .secondary)

                        Chart {
                            ForEach(dataType) { set in
                                BarMark(x: .value("Occurence", set.occurences),
                                         y: .value("Type", set.type),
                                        width: 12
                                ).cornerRadius(3)
                                    .opacity(showAverageOccurence ? 0.3 : 1)
                                if showAverageOccurence {
                                    RuleMark(x: .value("Average Occurence", averageOccurences()))
                                }
                            }
                        }
                        .chartYAxis(content: {
                            AxisMarks {
                                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.2))
                                AxisValueLabel()
                            }
                            
                        })
                        .chartXAxis {
                            AxisMarks(values: .stride(by: Float(1000000))) { value in
                                AxisGridLine().foregroundStyle(Color.black.opacity(0.1))
                                AxisValueLabel(format: Decimal.FormatStyle.number)
                            }
                        }
                        .foregroundStyle(LinearGradient(colors: [.blue, .mint], startPoint: .leading, endPoint: .center))
                    .frame(height: 400)
                    }
                }
                
               
            }
            .navigationTitle("👮‍♀️ Feeling Safe ?")
            .task {
                let rawData = FileReader.getContent(ofFileName: "summarizedDataSet", withExtension: "csv")
                guard var rows = rawData?.csvRows() else { return }
               
                rows.remove(at: 0) //Retrait de la ligne de titre du CSV
                rows.forEach { row in
                    dataType.append(DataPerType(type: row[4], occurences: Int(row[5])!))
                    
                    // Seuls les premières lignes du fichiers contiennent des données pour ces 2 types de données
                    if !row[1].isEmpty {
                        dataYear.append(DataPerYear(year: row[0], occurences: Int(row[1])!))
                        dataLocalization.append(DataPerLocalization(dept: row[2], occurences: Int(row[3])!))
                    }
                }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
