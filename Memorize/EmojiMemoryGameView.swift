//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eric Hou on 10/1/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // This var has an observable object and redraws the view whenever the var is changed (reactive)
    // For the sake of resources SwiftUI reacts only to the change and doesnt change everything
    @ObservedObject var viewModel: EmojiMemoryGame
    
    // body is called by the system and will never be referenced
    var body: some View {
        // Pointer to the class EmojiMemoryGame
        // Combiner
        HStack {
            // Combiner view with an interator
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
            // Applies to the ZStack
            .padding()
            // Gets passed down to views inside the ZStack
            .foregroundColor(Color.orange)
    }
}

// Swift is declarative and we're declaring how the UI looks
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        // Wrapper view that stores the offered space to a var
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        // Combiner layout view to build complex views
        ZStack {
            if card.isFaceUp {
                // Rounded Rectangle behavies like a view and a shape
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                // Stroke returns a view to use in the ZStack
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                // Text has an implicit parameter type
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        // Apllies to all text in the ZStack
        .font(Font.system(size: min(geometry.size.width, geometry.size.height)) * fontScaleFactor)
    }
    
    // MARK: - Drawing Constants
    
    // Using vars, lets and funcs to make the code as clean and understandable as possible
    // In simple terms, we're replacing all the blue numbers with names and concepts
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
