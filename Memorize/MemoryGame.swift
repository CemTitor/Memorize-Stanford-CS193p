//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cem Yılmaz on 22.02.2024.
//

import Foundation

struct MemoryGame<CardContent> {
    /// Only setting this variable is private, getting is allowed(not private)
    private (set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card){
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched: Bool = false
        let content: CardContent
    }
    
}
