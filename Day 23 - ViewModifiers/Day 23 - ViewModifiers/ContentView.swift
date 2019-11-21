//
//  ContentView.swift
//  Day 23 - ViewModifiers
//
//  Created by Timi Tejumola on 20/11/2019.
//  Copyright © 2019 Timi Tejumola. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns){ column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ContentView: View {
    @State private var useRedText = false
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        VStack {
            GridStack(rows: 4, columns: 4) { row, col in
                          Image(systemName: "\(row * 4 + col).circle")
                          Text("R\(row) C\(col)")
            }
            //conditional modifiers
            Button("Hello World"){
                self.useRedText.toggle()
            }
            //environment modifiers
            VStack {
                Text("Gryffindor")
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            .foregroundColor(useRedText ? .red : .blue)
            //view as a properties
            VStack {
                motto1
                motto2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
