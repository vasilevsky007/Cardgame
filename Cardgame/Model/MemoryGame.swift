//
//  MemoryGame.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import Foundation

struct MemoryGame<CardContent> {
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards=[Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        <#function body#>
    }
    
}
