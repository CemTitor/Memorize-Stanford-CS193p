//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Cem Yılmaz on 22.02.2024.
//

import Foundation
import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    typealias Card = MemoryGameModel<String>.Card
    
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
    @Published private var currentTheme: Theme
    
    // MARK: - Initializer
     init() {
         let initialTheme = EmojiMemoryGameViewModel.themes.randomElement()!
         self.currentTheme = initialTheme
         self.model = EmojiMemoryGameViewModel.createMemoryGame(theme: initialTheme)
     }

    // MARK: - Computed Properties
    var cards: [Card] {
         model.cards
     }
     
     var score: Int {
         model.score
     }
     
     var themeName: String {
         currentTheme.name
     }
     
     var themeColor: Color {
         currentTheme.color
     }
    
    // MARK: - Methods
    /// Temaya göre yeni bir `MemoryGameModel` oluşturur. cardContentFactory son parametre olduğu için closure syntax olarak yazdık
    private static func createMemoryGame(theme: Theme) -> MemoryGameModel<String> {
        return MemoryGameModel(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func changeTheme() {
        var newTheme: Theme
        repeat {
            newTheme = EmojiMemoryGameViewModel.themes.randomElement()!
        } while newTheme.name == currentTheme.name
        
        currentTheme = newTheme
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: currentTheme)
        model.shuffle()
    }
    
    func choose(_ card: MemoryGameModel<String>.Card){
        model.choose(card)
    }
}
