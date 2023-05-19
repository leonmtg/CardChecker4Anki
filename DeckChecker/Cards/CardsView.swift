//
//  CardsView.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import SwiftUI

struct CardsView: View {
  @StateObject private var cardsOO = CardsOO()
  
  var deckName: String
  
  var body: some View {
    VStack {
      HStack {
        Text("Hello, \(deckName)!")
        if cardsOO.fetching {
          ProgressView()
        }
      }
      .onAppear {
        cardsOO.fetchCards(with: deckName)
      }
      List(cardsOO.cards, id:\.id) { card in
        Text(card.orderFieldValue)
      }
    }
    .toolbar {
      CardsToolbarItems(cardsOO: cardsOO)
    }
  }
}

struct CardsView_Previews: PreviewProvider {
  static var previews: some View {
    CardsView(deckName: "Default")
  }
}
