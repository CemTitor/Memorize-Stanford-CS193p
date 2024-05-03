//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Cem Yılmaz on 22.02.2024.
//

import Foundation
import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    // MARK: - Static Properties
    /// static keyword koyarak themes degiskenini global yaparız. Neden global yapmak istiyoruz çünkü alttaki "model" property initinde themes kullanılamıyor çünkü themes "model"den sonra setleniyor. Yani themes' i kullanmadan önce initialize etmiş oluyorum.
    private static let themes: [Theme] = [
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"], numberOfPairs: 6, color: .green),
        Theme(name: "Fruits", emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈"], numberOfPairs: 5, color: .yellow),
        Theme(name: "Sports", emojis: ["⚽", "🏀", "🏈", "⚾", "🥎", "🏐", "🏉", "🎾", "🥏", "🎱"], numberOfPairs: 8, color: .blue),
        Theme(name: "Flags", emojis: ["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🇺🇳", "🇺🇸", "🇬🇧"], numberOfPairs: 5, color: .black),
        Theme(name: "Weather", emojis: ["☀️", "🌤", "⛅️", "🌥", "☁️", "🌦", "🌧", "⛈", "🌩", "🌨"], numberOfPairs: 4, color: .gray),
        Theme(name: "Faces", emojis: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇"], numberOfPairs: 5, color: .pink)
    ]
    // MARK: - Published Properties
    /// Published: Eğer bu variable değişirse, bir şeyin değiştiğini belirtecek
    @Published private var model: MemoryGameModel<String>
    @Published var themeColor: Color
    @Published var themeName: String
    
    typealias Card = MemoryGameModel<String>.Card
    
    // MARK: - Computed Properties
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Initialization
    init() {
        let theme = EmojiMemoryGameViewModel.themes.randomElement()!
        self.themeName = theme.name
        self.themeColor = theme.color
        self.model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    // MARK: - Methods
    /// Temaya göre yeni bir `MemoryGame` oluşturur. cardContentFactory son parametre olduğu için closure syntax olarak yazdık
    private static func createMemoryGame(theme: Theme) -> MemoryGameModel<String> {
        return MemoryGameModel<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        let newTheme = EmojiMemoryGameViewModel.themes.randomElement()!
        themeName = newTheme.name
        themeColor = newTheme.color
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: newTheme)
        model.shuffle()
    }
    
    func choose(_ card: MemoryGameModel<String>.Card){
        model.choose(card)
    }
}
