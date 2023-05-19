//
//  CardsToolbarItems.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/14.
//

import SwiftUI

struct CardsToolbarItems: ToolbarContent {
  @ObservedObject var cardsOO: CardsOO
  
  var body: some ToolbarContent {
    ToolbarItem {
      Button {
        cardsOO.checkDuplicates()
      } label: {
        Image(systemName: "line.horizontal.3")
      }
      .disabled(cardsOO.cards.isEmpty)
    }
  }
}
