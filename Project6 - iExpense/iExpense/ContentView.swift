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

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(
                            item.amount,
                            format: .currency(
                                code: Locale.current.currency?.identifier
                                    ?? "USD"
                            )
                        )
                    }
                }.onDelete(perform: removeItems)
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
