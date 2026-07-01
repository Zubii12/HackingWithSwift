//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
