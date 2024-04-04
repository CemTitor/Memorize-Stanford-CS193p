//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Cem Yılmaz on 15.02.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    @StateObject var game = EmojiMemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
