//
//  ContentView.swift
//  Memorize
//
//  Created by Eric Hou on 10/1/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Combiner
        HStack() {
            // Combiner view with an interator
            ForEach(0..<4) { index in
                // Combiner layout view to build complex views
                ZStack() {
                    // Rounded Rectangle behavies like a view and a shape
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                    // Stroke returns a view to use in the ZStack
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                    // Text has an implicit parameter type
                    Text("👻")
                }
            }
        }
            // Gets passed down to views inside the ZStack
            .foregroundColor(Color.orange)
            // Applies to the ZStack
            .padding()
            // Apllies to all text in the ZStack
            .font(Font.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
