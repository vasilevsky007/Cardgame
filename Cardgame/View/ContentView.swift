//
//  ContentView.swift
//  Cardgame
//
//  Created by Alex on 22.02.23.
//

import SwiftUI

struct EmojiTheme {
    let name:String
    let imageName:String
    let emojis:[Character]
}

let emojiThemes=[
    EmojiTheme(name: "Vehicles", imageName: "car.2", emojis: ["🚗","🚙","🚛","🛴","🚲","🏍️","🚃","🚋","🚞","🚝","🚄","🚅","🚈","🚂"]),
    EmojiTheme(name: "Smiles", imageName: "face.smiling", emojis: ["😀","😆","🥹","😅","😂","🥲","☺️","😊","😇","🙃","😍","😋","🤪","😎","🥳"]),
    EmojiTheme(name: "Animals", imageName: "pawprint", emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🐮","🦁","🐷","🐸","🐵"])
    
]
struct ThemeButton: View{
    var theme:EmojiTheme;
    var onTap:()->Void
    
    var body: some View{
        Button(action: onTap) {
            VStack{
                Image(systemName: theme.imageName)
                    .font(.largeTitle)
                Text(theme.name)
                    .font(.caption)
            }
        }
    }
}

struct ContentView: View {
    
    @State var emojis:[Character] = emojiThemes[0].emojis
    @State var emojiCount = emojiThemes[0].emojis.count
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive (minimum: 65))]) {
                    ForEach(emojis.shuffled()[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack{
                ForEach(emojiThemes.sorted(by: {$0.name<$1.name}), id: \.self.name) { theme in
                    ThemeButton(theme: theme, onTap: {
                        emojiCount = theme.emojis.count
                        emojis = theme.emojis
                        emojis.insert("0", at: 0)
                        emojis.removeFirst()
                    })
                    .aspectRatio(1, contentMode: .fit)
                }
            }

        }
        .padding(.horizontal)
    }
   
        
}

struct CardView: View {
    var content: Character
    @State var isFaceUp: Bool = true
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(String(content)).font(.largeTitle)
            } else {
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
