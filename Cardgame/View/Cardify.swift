//
//  Cardify.swift
//  Cardgame
//
//  Created by Alex on 6.03.23.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var isMatched: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.borderWidth)
                
            } else {
                shape.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
            if isMatched {
                shape.opacity(DrawingConstants.matchedOpacity)
            }
        }
    }
    
    private struct DrawingConstants {
        static let borderWidth: CGFloat = 3
        static let cardCornerRadius: CGFloat = 12
        static let matchedOpacity: CGFloat = 0.5
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
