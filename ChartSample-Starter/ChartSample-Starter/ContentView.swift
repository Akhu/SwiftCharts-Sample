//
//  ContentView.swift
//  ChartSample-Starter
//
//  Created by Anthony Da cruz on 26/09/2022.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State var dataLocalization = [DataPerLocalization]()
    @State var dataType = [DataPerType]()
    @State var dataYear = [DataPerYear]()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Où sont les données ?")
                Link("Aller vers le tutoriel", destination: URL(string: "tuto-dataviz-creer-une-app-mobile-avec-swift-charts-et-swiftui")!)
            }
            .padding()
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
                    //Todo : Ajouter la répartition par département ici
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
