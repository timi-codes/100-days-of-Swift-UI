//
//  ContentView.swift
//  Day 27 - BetterRest
//
//  Created by Timi Tejumola on 23/11/2019.
//  Copyright © 2019 Timi Tejumola. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var cofeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(value: $cofeeAmount, in: 1...20) {
                        if cofeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(cofeeAmount) cups")
                        }
                    }
                }
            }
        .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                Button(action: calculateBedtime){
                    Text("Calculate")
                }
            )
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date()
    }
    
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do{
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Double(cofeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
        }catch{
            //something went wrong
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bed time."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
