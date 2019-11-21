//
//  ContentView.swift
//  WeSplit-Day-1
//
//  Created by Timi Tejumola on 17/11/2019.
//  Copyright © 2019 Timi Tejumola. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipAmount = tipSelection / 100 * orderAmount
        let grandTotal = orderAmount + tipAmount
        let amountPerson = grandTotal / peopleCount
        
        return amountPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount ", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave")) {
                    Picker("Tip percentages", selection: $tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

