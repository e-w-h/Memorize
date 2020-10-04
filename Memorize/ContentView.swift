//
//  ContentView.swift
//  Memorize
//
//  Created by Eric Hou on 10/1/20.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        // Pointer to the class EmojiMemoryGame
        // Combiner
        HStack {
            // Combiner view with an interator
            ForEach(viewModel.cards) { card in
                CardView(card: card)
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

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        // Combiner layout view to build complex views
        ZStack {
            if card.isFaceUp {
                // Rounded Rectangle behavies like a view and a shape
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                // Stroke returns a view to use in the ZStack
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                // Text has an implicit parameter type
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
