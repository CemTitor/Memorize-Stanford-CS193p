//
//  ContentView.swift
//  Memorize
//
//  Created by Cem Yılmaz on 15.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)

            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("x").font(.largeTitle)

            } else {
                base.fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}


