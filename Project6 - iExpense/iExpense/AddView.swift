//
//  AddView.swift
//  iExpense
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import SwiftUI

struct AddView: View {
    var expenses: Expenses

    @State private var name = ""
    @State private var type: ExpenseItemType = .personal
    @State private var amount = 0.0

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseItemType.allCases, id: \.self) {
                        Text($0.title)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(
                        code: Locale.current.currency?.identifier ?? "USD"
                    )
                )
                .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount
                    )
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
