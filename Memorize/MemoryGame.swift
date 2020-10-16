//
//  MemoryGame.swift
//  Memorize
//
//  Created by Eric Hou on 10/2/20.
//

import Foundation

// Constrains and gains for comparing two generics to be equatable with == function
struct MemoryGame<CardContent> where CardContent: Equatable {
    // Setting is private but reading is not
    private(set) var cards: Array<Card>
    
    // Use an optional which isn't set and gets initialized to nil
    // Use a computed var to avoid having state in two different places which can lead to errors
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                // newValue is a variable thats included in and unique to set
                // newValue is the same value as whatever the variable is at the time set is called
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // Cant be private since its used for playing the game
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
    
    // Private inits exist but are rare
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // Create an empty array of cards
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    // The only way to get a card is through the cards array which is already private(set)
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
    // MARK: - Bonus Time
    
    // this could give matching bonus points if the user matches the card
    // before a certain amount of time passes during which the card is face up
    
    // can be zero which means "no bonus available" for this card
    var bonusTimeLimit: TimeInterval = 6
    
    // how long this card has ever been face up
    private var faceUpTime: TimeInterval {
        if let lastFaceUpDate = self.lastFaceUpDate {
            return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
        } else {
            return pastFaceUpTime
        }
    }
    
    // the last time this card was turned face up (and is still face up)
    var lastFaceUpDate: Date?
    
    // the accumulated time this card has been face up in the past
    var pastFaceUpTime: TimeInterval = 0
    
    // how much time left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
        max(0, bonusTimeLimit - faceUpTime)
    }
    
    // percentage of the bonus time remaining
    var bonusRemaining: Double {
        (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
    // whether the card was matched during the bonus time period
    var hasEarnedBonus: Bool {
    }
    
    // whether we are currently face up, unmatched and have not yet used the bonus window
    var isConsumingBonusTime: Bool {
        
    }
    
    // called when the card transitions to face up state
    private mutating func startUsingBonusTime() {
        if isConsumingBonusTime, lastFaceUpDate == nil {
            lastFaceUpDate = Date()
        }
    }
    
    // called when the card goes back to face down (or gets matched)
    private mutating func stopUsingBonusTime() {
        pastFaceUpTime = faceUpTime
        self.lastFaceUpDate = nil
    }
}
