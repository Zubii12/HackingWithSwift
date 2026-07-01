//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import Foundation

enum ExpenseItemType: Codable, CaseIterable {
    case personal
    case business

    var title: String {
        switch self {
        case .personal: return "Personal"
        case .business: return "Business"
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseItemType
    let amount: Double
}
