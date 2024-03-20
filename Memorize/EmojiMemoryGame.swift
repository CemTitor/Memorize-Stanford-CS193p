//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Cem Yılmaz on 22.02.2024.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    /// static keyword koyarak emojis degiskenini global yaparız. Neden global yapmak istiyoruz çünkü alttaki "model" property initinde emojis kullanılamıyor çünkü emojis
    /// "model"den sonra setleniyor. Yani emojis' i kullanmadan önce initialize etmiş oluyorum.
    private static let emojis = ["🚑","🛵","✈️","🚘","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️"]
    
    ///cardContentFactory son parametre olduğu için closure syntax olarak yazdık.
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    /// Published: Eğer bu variable değişirse, bir şeyin değiştiğini belirtecek
    @Published private var model = createMemoryGame()
    
    /// Bu şekilde de yazılabilir
    //    private var model = MemoryGame(numberOfPairsOfCards: 4) {
    //        return emojis[$0]
    //    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
