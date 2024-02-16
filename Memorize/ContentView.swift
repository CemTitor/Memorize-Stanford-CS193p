//
//  ContentView.swift
//  Memorize
//
//  Created by Cem Yılmaz on 15.02.2024.
//

import SwiftUI

struct ContentView: View {
    let theme1: Array<String> = ["🐻","🐱","🐤","🦊","🐸","🐸","🐸","🐸","🐸","🐸","🐸","🐸"]
    let theme2: [String] = ["😆","😆","😆","😆","😆","😆","😆","😆","😆","😆","😆","😆",]
    let theme3 = ["🚑","🛵","✈️","🚘","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️","🛳️"]
    
    @State private var choosenTheme: [String]
    @State private var choosenColor: Color
    @State private var randomCardnumber: Int

    init() {
        _choosenTheme = State(initialValue: theme1)
        _choosenColor = State(initialValue: .orange)
        _randomCardnumber = State(initialValue: 3)
    }
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(0..<randomCardnumber, id: \.self) { index in
                CardView(content: choosenTheme[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(choosenColor)
    }
    
    func cardCountAdjuster(by theme: [String], symbol: String, title: String, color: Color) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(color)
            Button(action: {
                choosenTheme = theme.shuffled()
                choosenColor = color
                randomCardnumber = Int.random(in: 2...10)
            }, label: {
                Image(systemName: symbol)
                    .imageScale(.large)
                    .foregroundColor(color)
                
            })
        }
    }

    
    var cardCountAdjusters: some View {
        HStack {
            themeButton
            themeButton2
            themeButton3
        }
        .imageScale(.large)
        .font(.largeTitle)
        .fixedSize(horizontal: true, vertical: true)
    }
    
    var themeButton: some View {
        cardCountAdjuster(by: theme1, symbol: "pawprint", title: "Animals", color: .orange)
    }
    
    var themeButton2: some View {
        cardCountAdjuster(by: theme2, symbol: "smiley", title: "Smileys", color: .blue)
    }
    
    var themeButton3: some View {
        cardCountAdjuster(by: theme3, symbol: "bus", title: "Vehicles", color: .red)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}


