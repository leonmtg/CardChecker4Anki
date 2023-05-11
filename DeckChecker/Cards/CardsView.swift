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
    HStack {
      Text("Hello, \(deckName)!")
      if cardsOO.fetching {
        ProgressView()
      }
    }
    .onAppear {
      cardsOO.fetchCards(with: deckName)
    }
  }
}

struct CardsView_Previews: PreviewProvider {
  static var previews: some View {
    CardsView(deckName: "Default")
  }
}
