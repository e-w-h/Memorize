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
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        // Doesnt need self because a struct is a value type and doesnt live in the heap
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
                // Applies to the ZStack
                .padding()
                // Gets passed down to views inside the ZStack
                .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
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
    
    // Modifier for a function that returns a list of view or an empty view
    @ViewBuilder
    // Helper function can be private
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            // Combiner layout view to build complex views
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                // Text has an implicit parameter type
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            .rotation3DEffect(Angle.degrees(card.isFaceUp ?  0 : 180), axis: (0, 1 , 0))
        }
    }
    
    // MARK: - Drawing Constants
    
    // Using vars, lets and funcs to make the code as clean and understandable as possible
    // In simple terms, we're replacing all the blue numbers with names and concepts
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
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
