//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Cem Yılmaz on 15.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    /// Eğer bir şey değişiyorsa, beni yeniden çiz
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let emojis: Array<String> = ["🐻","🐱","🐤","🦊","🐸","🐸","🐸","🐸","🐸","🐸","🐸","🐸"]

//    let theme1: Array<String> = ["🐻","🐱","🐤","🦊","🐸","🐸","🐸","🐸","🐸","🐸","🐸","🐸"]
//    let theme2: [String] = ["😆","😆","😆","😆","😆","😆","😆","😆","😆","😆","😆","😆",]
//    let theme3 = ["🚑","🛵","✈️","🚘","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️"]
    
//    @State private var choosenTheme: [String]
//    @State private var choosenColor: Color
//    @State private var randomCardnumber: Int
//
//    init() {
//        _choosenTheme = State(initialValue: theme1)
//        _choosenColor = State(initialValue: .orange)
//        _randomCardnumber = State(initialValue: 3)
//    }
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
//            cardCountAdjusters
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
//        .foregroundColor(choosenColor)
    }
    
//    func cardCountAdjuster(by theme: [String], symbol: String, title: String, color: Color) -> some View {
//        VStack {
//            Text(title)
//                .font(.caption)
//                .foregroundColor(color)
//            Button(action: {
//                choosenTheme = theme.shuffled()
//                choosenColor = color
//                randomCardnumber = Int.random(in: 2...10)
//            }, label: {
//                Image(systemName: symbol)
//                    .imageScale(.large)
//                    .foregroundColor(color)
//                
//            })
//        }
//    }
//
//    
//    var cardCountAdjusters: some View {
//        HStack {
//            themeButton
//            themeButton2
//            themeButton3
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//        .fixedSize(horizontal: true, vertical: true)
//    }
//    
//    var themeButton: some View {
//        cardCountAdjuster(by: theme1, symbol: "pawprint", title: "Animals", color: .orange)
//    }
//    
//    var themeButton2: some View {
//        cardCountAdjuster(by: theme2, symbol: "smiley", title: "Smileys", color: .blue)
//    }
//    
//    var themeButton3: some View {
//        cardCountAdjuster(by: theme3, symbol: "bus", title: "Vehicles", color: .red)
//    }

}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}


