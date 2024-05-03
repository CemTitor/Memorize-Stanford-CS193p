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
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.themeColor)
    }
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
