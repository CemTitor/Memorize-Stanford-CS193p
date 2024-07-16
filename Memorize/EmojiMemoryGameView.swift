//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Cem Yılmaz on 15.02.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    typealias Cards = MemoryGameModel<String>.Card
    /// ObservedObject amacı: Eğer bir şey değişiyorsa, beni yeniden çiz
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack{
            Text(viewModel.themeName)
                .font(.headline)
                .padding()
            Text("Memorize!")
                .font(.largeTitle)
            cards
                .animation(.default, value: viewModel.cards )
            shuffle
            Spacer()
            score
            Spacer()
            Button("New Game") {
                viewModel.newGame()
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
           0
       }
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
