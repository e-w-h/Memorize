//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eric Hou on 10/2/20.
//

import SwiftUI

class EmojiMemoryGame {
    // private(set) allows multiple views to look at but not change the model
    // Closure - inlining a function in the functional language Swift
    // Type inference in a strongly typed language removes the need for restating types
    // Use the underbar (_) when the variable isnt used in the function
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // Static functions get sent to the type
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃"]
        // Type inference and closure cuts down the amount of code dramatically
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
