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
        EmojiTheme(name: "Vehicles", colorName: "red", numberOfPairsToShow: 8, emojis: ["🚗","🚙","🚛","🛴","🚲","🏍️","🚃","🚋","🚞","🚝","🚄","🚅","🚈","🚂"]),
        EmojiTheme(name: "Smiles", colorName: "yellow", numberOfPairsToShow: 8, emojis: ["😀","😆","🥹","😅","😂","🥲","☺️","😊","😇","🙃","😍","😋","🤪","😎","🥳"]),
        EmojiTheme(name: "Animals", colorName: "green", numberOfPairsToShow: 8, emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🐮","🦁","🐷","🐸","🐵"])
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

