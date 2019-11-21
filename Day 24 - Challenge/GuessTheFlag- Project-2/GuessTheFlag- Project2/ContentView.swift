//
//  ContentView.swift
//  GuessTheFlag- Project2
//
//  Created by Timi Tejumola on 18/11/2019.
//  Copyright © 2019 Timi Tejumola. All rights reserved.
//

import SwiftUI

struct FlagImage : View {
    var image: String
    
    var body:  some View {
        Image(image)
            .renderingMode(.original)
             .clipShape(Capsule())
             .overlay(Capsule().stroke(Color.black, lineWidth: 1))
         .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
     @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var myScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
               VStack {
                   Text("Tap the flag of")
                    .foregroundColor(.white)
                
                   Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    
               }
               ForEach(0..<3){ number in
                   Button(action: {
                    self.flagTapped(number)
                   }) {
                        FlagImage(image : self.countries[number])
                   }
               }
                Spacer()
                VStack {
                    Text("Current Score")
                        .foregroundColor(.white)
                    Text("\(myScore)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is \(myScore)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            myScore+=1
        } else {
            scoreTitle = "Wrong"
            myScore = 0
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

