//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cem Yılmaz on 22.02.2024.
//

import Foundation

struct MemoryGame<CardContent> where  CardContent: Equatable{
    /// Only setting this variable is private, getting is allowed(not private)
    private (set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter {index  in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card){
        //        if let choosenIndex = index(of: card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched {
                if let potantialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choosenIndex].content == cards[potantialMatchIndex].content {
                        cards[choosenIndex].isMatched = true
                        cards[potantialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = choosenIndex
                }
                cards[choosenIndex].isFaceUp = true
                ///Cannot use mutating member on immutable value: parameter 'card' is a 'let' constant, so we are going to use cards[index] justlike above
                //        card.isFaceUp.toggle() //
            }
        }
    }
    
    /// index methodunu kullanmak yerine yukarıda array'in zaten sahio olduğu firstIndex() methodunu kullandık
    //    private func index(of card: Card) -> Int? {
    //        for index in cards.indices {
    //            if cards[index].id == card.id {
    //                return index
    //            }
    //        }
    //        return nil
    //    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
        /// CustomDebugStringConvertible conform ederek  printte aldığımız çıktıdaki texti daha düzgün yazarız.
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
    }
    
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
