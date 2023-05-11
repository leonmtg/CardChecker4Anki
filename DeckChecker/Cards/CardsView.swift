//
//  CardsView.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import SwiftUI

struct CardsView: View {
  var deckName: String
  
  var body: some View {
    Text("Hello, \(deckName)!")
  }
}

struct CardsView_Previews: PreviewProvider {
  static var previews: some View {
    CardsView(deckName: "Default")
  }
}
