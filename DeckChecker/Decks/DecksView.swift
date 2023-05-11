//
//  DecksView.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/9.
//

import SwiftUI

struct DecksView: View {
  @StateObject private var decksOO = DecksOO()
  
  var body: some View {
    NavigationStack {
      List(decksOO.decks.deckNames, id: \.self) { name in
        NavigationLink(destination: CardsView(deckName: name)) {
          Text(name)
        }
      }
      .listStyle(.plain)
    }
    .navigationTitle("Decks")
    .padding()
    .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity,
           minHeight: 300, idealHeight: 400, maxHeight: .infinity)
    .onAppear {
      decksOO.fetchDecks()
    }
  }
}

struct DecksView_Previews: PreviewProvider {
  static var previews: some View {
    DecksView()
  }
}
