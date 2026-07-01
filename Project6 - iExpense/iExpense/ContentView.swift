//
//  ContentView.swift
//  iExpense
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import SwiftUI

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode(
                [ExpenseItem].self,
                from: savedItems
            ) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()

    @State private var showingAddExpense = false

    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == .personal }
    }

    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == .business }
    }

    func removePersonalItems(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { personalItems[$0] }

        for item in itemsToDelete {
            if let index = expenses.items.firstIndex(where: { $0.id == item.id }
            ) {
                expenses.items.remove(at: index)
            }
        }
    }

    func removeBusinessItems(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { businessItems[$0] }

        for item in itemsToDelete {
            if let index = expenses.items.firstIndex(where: { $0.id == item.id }
            ) {
                expenses.items.remove(at: index)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(personalItems) { item in
                        ExpenseItemView(item: item)
                    }.onDelete(perform: removePersonalItems)
                }
                .foregroundStyle(.black)

                Section("Business") {
                    ForEach(businessItems) { item in
                        ExpenseItemView(item: item)
                    }.onDelete(perform: removeBusinessItems)
                }
                .foregroundStyle(.black)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
}

#Preview {
    ContentView()
}
