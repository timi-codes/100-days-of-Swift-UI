//
//  ContentView.swift
//  Day 26 - BetterRest
//
//  Created by Timi Tejumola on 23/11/2019.
//  Copyright © 2019 Timi Tejumola. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        Form {
            Group {
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                               Text("\(sleepAmount, specifier: "%g") hours")
                           }
                DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
//                .labelsHidden()
                
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
