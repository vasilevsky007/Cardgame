//
//  EmojiMemoryGameView.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import SwiftUI

private struct DrawingConstants {
    static let borderWidth: CGFloat = 3
    static let cardPadding: CGFloat = 1
    static let cardAspectRatio: CGFloat = 2/3
    static let cardCornerRadius: CGFloat = 20
    static let opacityOfMatched: CGFloat = 0.5
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
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive (minimum: 75))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .padding(.all, DrawingConstants.cardPadding)
                            .aspectRatio(DrawingConstants.cardAspectRatio, contentMode: .fit)
                            .onTapGesture { game.choose(card) }
                    }
                }
            }
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
            ZStack{
                       let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
                       if card.isFaceUp{
                           shape.fill().foregroundColor(.white)
                           shape.strokeBorder(lineWidth: DrawingConstants.borderWidth)
                           Text(String(card.content)).font(generateSystemFontToFit(geometry))
                       } else {
                           shape.fill()
                       }
                       if card.isMatched {
                           shape.opacity(DrawingConstants.opacityOfMatched)
                       }
                   }
        }
       
    }
    
}

private func generateSystemFontToFit(_ geometry: GeometryProxy) ->Font {
    Font.system(size: min(geometry.size.height, geometry.size.width) * 0.75)
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
