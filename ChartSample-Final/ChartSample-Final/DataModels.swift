//
//  DataModels.swift
//  ChartsSample-1
//
//  Created by Anthony Da cruz on 26/09/2022.
//

import Foundation

//Structure pour le graphique de répartition des infractions par années
struct DataPerYear : Identifiable {
    let id = UUID()
    // Classe
    let year: String
    
    // Nombres de faits survenus
    let occurences: Int
}

//Structure pour le graphique de répartition des infractions par département
struct DataPerLocalization: Identifiable {
    let id = UUID()
    
    // Le département concerné
    let dept: String
    
    // Nombres de faits survenus
    let occurences: Int
}

//Structure pour le graphique de répartition des infractions par type
struct DataPerType: Identifiable {
    let id = UUID()
    
    //Type d'infractions, il y en a 11 en tout
    let type: String
    
    // Nombres de faits survenus
    let occurences: Int
}
