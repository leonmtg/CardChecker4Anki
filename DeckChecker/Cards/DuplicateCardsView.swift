//
//  DuplicateCardsView.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/22.
//

import SwiftUI

struct DuplicateCardsView: View {
  @ObservedObject var cardsOO: CardsOO
  
  var body: some View {
    VStack {
      Text("Hello, Duplicates!")
      
      List(cardsOO.duplicateCards, id: \.id) { card in
        Text(card.orderFieldValue)
      }
    }
    .frame(minWidth: 350, idealWidth: 500, maxWidth: .infinity,
           minHeight: 250, idealHeight: 300, maxHeight: .infinity)
  }
}

struct DuplicateCardsView_Previews: PreviewProvider {
  @State private static var cardsOO = CardsOO()
  
  static var previews: some View {
    DuplicateCardsView(cardsOO: cardsOO)
  }
}
