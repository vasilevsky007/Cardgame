//
//  EmojiMemoryGameView.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import SwiftUI


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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.timerPadding).opacity(DrawingConstants.timerOpacity)
                Text(String(card.content))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
        }
    }
}

private func scale(thatFits size: CGSize) -> CGFloat {
    min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
}



private struct DrawingConstants {
    static let borderWidth: CGFloat = 3
    static let cardPadding: CGFloat = 4
    static let timerPadding: CGFloat = 5
    static let cardAspectRatio: CGFloat = 2/3
    static let cardCornerRadius: CGFloat = 12
    static let fontScale: CGFloat = 0.7
    static let fontSize: CGFloat = 32
    static let timerOpacity: CGFloat = 0.5
    static let buttonCornerRadius: CGFloat = 10
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
