//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Cem Yılmaz on 15.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    /// ObservedObject amacı: Eğer bir şey değişiyorsa, beni yeniden çiz
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack{
            Text(viewModel.themeName)
                .font(.headline)
                .padding()
            Text("Memorize!")
                .font(.largeTitle)
            cards
                .animation(.default, value: viewModel.cards )
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            Button("New Game") {
                viewModel.newGame()
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.themeColor)
    }
    
}

struct CardView: View {
    let card: MemoryGameModel<String>.Card
    
    init(_ card: MemoryGameModel<String>.Card) {
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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
