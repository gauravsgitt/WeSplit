//
//  ContentView.swift
//  WeSplit
//
//  Created by Gaurav Bisht on 30/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfPeople = 2
    @State private var amount = 0.0
    @State private var selectedTipPercentage = 0
    @FocusState private var isAmountTextFieldFocued: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20]
    var tipAmount: Double { (Double(selectedTipPercentage) / 100) * amount }
    var totalAmount: Double { amount + tipAmount }
    var perPersonAmount: Double {
        
        return numberOfPeople == 0 ? 0.0 : (totalAmount / Double(numberOfPeople + 2))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountTextFieldFocued)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $selectedTipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("How much do you want to tip?")
                        .textCase(.uppercase)
                }
                
                Section("Amount per person") {
                    Text(perPersonAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
                
                Section("total amount for the check") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .foregroundStyle(selectedTipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isAmountTextFieldFocued {
                    Button("Done") {
                        isAmountTextFieldFocued = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
