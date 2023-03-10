//
//  EmojiTheme.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import Foundation

struct EmojiTheme {
    let name: String
    let colorName: String
    let numberOfPairsToShow: Int
    let emojis: Set<Character>
}

struct EmojiThemes {
   static var list = [
        EmojiTheme(name: "Vehicles", colorName: "red", numberOfPairsToShow: 8, emojis: ["ð","ð","ð","ðī","ðē","ðïļ","ð","ð","ð","ð","ð","ð","ð","ð"]),
        EmojiTheme(name: "Smiles", colorName: "yellow", numberOfPairsToShow: 8, emojis: ["ð","ð","ðĨđ","ð","ð","ðĨē","âšïļ","ð","ð","ð","ð","ð","ðĪŠ","ð","ðĨģ"]),
        EmojiTheme(name: "Animals", colorName: "green", numberOfPairsToShow: 8, emojis: ["ðķ","ðą","ð­","ðđ","ð°","ðĶ","ðŧ","ðž","ðŧââïļ","ðĻ","ðŊ","ðŪ","ðĶ","ð·","ðļ","ðĩ"])
    ]
    
    var currentThemeIndex: Int = 0 {
        didSet {
            if currentThemeIndex >= EmojiThemes.list.count {
                currentThemeIndex = 0
            }
        }
    }
    
    var currentTheme: EmojiTheme {
        get { EmojiThemes.list[currentThemeIndex] }
    }
    
    
}

