//
//  EmojiMemoryGame.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import SwiftUI

extension Color {
    public static func named(_ name: String) -> Color {
        let cleanedName = name.replacingOccurrences(of: " ", with: "").lowercased()
        switch cleanedName {
        case "black": return .black
        case "blue": return .blue
        case "brown": return .brown
        case "clear": return .clear
        case "cyan": return .cyan
        case "gray": return .gray
        case "green": return .green
        case "orange": return .orange
        case "purple": return .purple
        case "red": return .red
        case "teal": return .teal
        case "white": return .white
        case "yellow": return .yellow
        case "pink": return .pink
        case "mint": return .mint
        case "indigo": return .indigo
        default: return .accentColor
        }
    }
}

class EmojiMemoryGame: ObservableObject {
    private var themes = EmojiThemes()
    
    private func createEmojiMemoryGame() -> MemoryGame<Character> {
        themes.currentThemeIndex = Int.random(in: EmojiThemes.list.indices)
        let startingIndex = Int.random(in: 0..<(themes.currentTheme.emojis.count - themes.currentTheme.numberOfPairsToShow))
        return MemoryGame<Character>(numberOfPairsOfCards: min(themes.currentTheme.numberOfPairsToShow, themes.currentTheme.emojis.count)) { pairIndex in
            themes.currentTheme.emojis.sorted()[pairIndex + startingIndex]
        }
    }
    
    @Published private var model: MemoryGame<Character>
    
    var cards: Array<MemoryGame<Character>.Card> {
        model.cards
    }
    
    var themeColor: Color {
        .named(themes.currentTheme.colorName)
    }
    
    var themeName: String{
        themes.currentTheme.name
    }
    
    var currentScore: String {
        String(model.score)
    }
    
    init() {
        model = MemoryGame<Character>(numberOfPairsOfCards: 0, createCardContent: {_ in "a"}) //bogus xd
        model = createEmojiMemoryGame()
    }
    
//    MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<Character>.Card){
        model.choose(card)
    }
    
    func startNewGame() {
        model = createEmojiMemoryGame()
    }
}
