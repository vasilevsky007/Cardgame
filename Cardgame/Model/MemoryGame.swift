//
//  MemoryGame.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    struct Card: Identifiable{
        var isFaceUp = false
        var isMatched = false
        var wasPreviouslySeen = false
        var content: CardContent
        var id: Int
    }
    private(set) var cards: [Card]
    
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp && !cards[$0].isMatched }).oneAndOnly }
        set { cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue) || cards[$0].isMatched }) }
    }
    
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards=[Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else{
                    cards[chosenIndex].wasPreviouslySeen ? (score -= 1)  : (score -= 0)
                    cards[potentialMatchIndex].wasPreviouslySeen ? (score -= 1) : (score -= 0)
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].wasPreviouslySeen = true
            } else {
               indexOfFaceUpCard = chosenIndex
            }
            
        }
    }
}

extension Array{
    var oneAndOnly :Element? {
        self.count == 1 ? self.first : nil
    }
}
