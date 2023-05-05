import SwiftUI

struct CardView: View {

    var card: Card

    var body: some View {
        ZStack(alignment: .center) {
            Text(card.secretCode.uuidString)
                .lineLimit(4, reservesSpace: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 128)
            RoundedRectangle(cornerRadius: 32)
                .stroke(lineWidth: 8)
                .frame(width: 196, height: 196)
                .foregroundColor(card.isActivated ? Color.green : Color.blue)
                .overlay {
                    if !card.isScratched {
                        Color.yellow
                            .cornerRadius(32)
                    }
                }
        }
        .animation(.default, value: card.isActivated)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(state: .inactive, isScratched: false))
    }
}
