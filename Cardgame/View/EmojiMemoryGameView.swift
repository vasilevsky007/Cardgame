//
//  EmojiMemoryGameView.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import SwiftUI

private struct DrawingConstants {
    static let borderWidth: CGFloat = 3
    static let cardPadding: CGFloat = 4
    static let timerPadding: CGFloat = 5
    static let cardAspectRatio: CGFloat = 2/3
    static let cardCornerRadius: CGFloat = 12
    static let fontScale: CGFloat = 0.7
    static let matchedOpacity: CGFloat = 0.5
    static let timerOpacity: CGFloat = 0.5
    static let buttonCornerRadius: CGFloat = 10
    
}

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            HStack{
                Spacer()
                Text("Score: " + game.currentScore)
                    .font(.title2)
            }
            
            Divider()
            
            AspectVGrid(items: game.cards, aspectRatio: DrawingConstants.cardAspectRatio, content: { card in
                CardView(card: card)
                    .padding(.all, DrawingConstants.cardPadding)
                    .onTapGesture { game.choose(card) }
            })
            .foregroundColor(game.themeColor)
            
            Spacer()
            
            Divider()
            
            HStack {
                Text("Theme: "+game.themeName)
                Spacer()
                Button {
                    game.startNewGame()
                } label: {
                    Text("New Game")
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .background{
                    RoundedRectangle(cornerRadius: DrawingConstants.buttonCornerRadius).strokeBorder(lineWidth: DrawingConstants.borderWidth)
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal)
            .font(.title3)
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
    }
   
}

struct CardView: View {
    let card: MemoryGame<Character>.Card
    var body: some View{
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
                if card.isFaceUp{
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.borderWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.timerPadding).opacity(DrawingConstants.timerOpacity)
                    Text(String(card.content)).font(generateSystemFontToFit(geometry))
                } else {
                    shape.fill()
                }
                if card.isMatched {
                    shape.opacity(DrawingConstants.matchedOpacity)
                }
            }
        }
       
    }
    
}

private func generateSystemFontToFit(_ geometry: GeometryProxy) ->Font {
    Font.system(size: min(geometry.size.height, geometry.size.width) * DrawingConstants.fontScale)
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
