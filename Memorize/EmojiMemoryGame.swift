//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eric Hou on 10/2/20.
//

import SwiftUI

class EmojiMemoryGame {
    // private(set) allows multiple views to look at but not change the model
    // Closure - inlining a function in Swift
    private var game: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) { _ in "😀" }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
