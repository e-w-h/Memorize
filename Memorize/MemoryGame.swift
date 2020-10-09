//
//  MemoryGame.swift
//  Memorize
//
//  Created by Eric Hou on 10/2/20.
//

import Foundation

// Constrains and gains for comparing two generics to be equatable with == function
struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    // Use an optional which isn't set and gets initialized to nil
    // Use a computed var to avoid having state in two different places which can lead to errors
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                // newValue is a variable thats included in and unique to set
                // newValue is the same value as whatever the variable is at the time set is called
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        // Comma is a sequential && which only executes the latter cases if the first case is true
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // Using the equatable constraint so that we can compare the card contents
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // Create an empty array of cards
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
