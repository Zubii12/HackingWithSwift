//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import SwiftUI

struct ExpenseItemView: View {
    var item: ExpenseItem

    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)

            Spacer()

            let currencyCode =
                Locale.current.currency?.identifier ?? "USD"

            if item.amount < 10 {
                Text(
                    item.amount,
                    format: .currency(code: currencyCode)
                )
                .foregroundColor(.green)
                .font(.footnote)
            } else if item.amount < 100 {
                Text(
                    item.amount,
                    format: .currency(code: currencyCode)
                )
                .foregroundColor(.orange)
                .font(.headline)
            } else {
                Text(
                    item.amount,
                    format: .currency(code: currencyCode)
                )
                .foregroundColor(.red)
                .font(.title3)
                .bold()
            }
        }
    }
}
