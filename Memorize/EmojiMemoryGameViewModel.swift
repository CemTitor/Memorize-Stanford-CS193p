//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Cem Yılmaz on 22.02.2024.
//

import Foundation

class EmojiMemoryGameViewModel: ObservableObject {
    /// static keyword koyarak themes degiskenini global yaparız. Neden global yapmak istiyoruz çünkü alttaki "model" property initinde themes kullanılamıyor çünkü themes "model"den sonra setleniyor. Yani themes' i kullanmadan önce initialize etmiş oluyorum.    
    private static let themes: [Theme] = [
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"], numberOfPairs: 6, color: .green),
        Theme(name: "Fruits", emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈"], numberOfPairs: 5, color: .yellow),
        Theme(name: "Sports", emojis: ["⚽", "🏀", "🏈", "⚾", "🥎", "🏐", "🏉", "🎾", "🥏", "🎱"], numberOfPairs: 8, color: .blue),
        Theme(name: "Flags", emojis: ["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🇺🇳", "🇺🇸", "🇬🇧"], numberOfPairs: 5, color: .black),
        Theme(name: "Weather", emojis: ["☀️", "🌤", "⛅️", "🌥", "☁️", "🌦", "🌧", "⛈", "🌩", "🌨"], numberOfPairs: 4, color: .gray),
        Theme(name: "Faces", emojis: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇"], numberOfPairs: 5, color: .pink)
    ]
    
    ///cardContentFactory son parametre olduğu için closure syntax olarak yazdık.
    static func createMemoryGame() -> MemoryGameModel<String> {
        let theme = themes.randomElement()!
        return MemoryGameModel(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
               theme.emojis[pairIndex]
           }
    }
        
    /// Published: Eğer bu variable değişirse, bir şeyin değiştiğini belirtecek
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model = EmojiMemoryGameViewModel.createMemoryGame()
        model.shuffle()
    }
    
    func choose(_ card: MemoryGameModel<String>.Card){
        model.choose(card)
    }
}
