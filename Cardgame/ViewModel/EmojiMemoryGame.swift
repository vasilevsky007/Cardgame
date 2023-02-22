//
//  EmojiMemoryGame.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis: Array<Character> = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🐮","🦁","🐷","🐸","🐵"]
    private static func createEmojiMemoryGame() -> MemoryGame<Character> {
        MemoryGame<Character>(numberOfPairsOfCards: 4) {pairIndex in emojis[pairIndex] }
    }
    
    private var model = createEmojiMemoryGame()
    var cards: Array<MemoryGame<Character>.Card> {
        return model.cards
    }
}
