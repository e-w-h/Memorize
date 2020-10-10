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
        // Grid can be thought of as a 2D HStack
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                // Doesnt need self because a struct is a value type and doesnt live in the heap
                viewModel.choose(card: card)
            }
            .padding(5)
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
    
    // Helper function can be private
    private func body(for size: CGSize) -> some View {
        // Combiner layout view to build complex views
        ZStack {
            if card.isFaceUp {
                // Rounded Rectangle behavies like a view and a shape
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                // Stroke returns a view to use in the ZStack
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Circle()
                // Text has an implicit parameter type
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        // Apllies to all text in the ZStack
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    // Using vars, lets and funcs to make the code as clean and understandable as possible
    // In simple terms, we're replacing all the blue numbers with names and concepts
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

// Creates a preview for our memory game
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Change the preview conditions so that we can easily work on the circular background timer
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
