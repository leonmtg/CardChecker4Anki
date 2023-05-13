//
//  DecksOO.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/9.
//

import SwiftUI

class DecksOO: ObservableObject {
  private let ankiService: AnkiServiceDataPublisher
  
  @Published public var decks = Decks.emptyDecks
  
  public init(ankiService: AnkiServiceDataPublisher = AnkiService()) {
    self.ankiService = ankiService
  }
  
  public func fetchDecks() {
    ankiService.decksPublisher()
      .decode(type: Decks.self, decoder: JSONDecoder())
      .replaceError(with: Decks.errorDecks)
      .receive(on: DispatchQueue.main)
      .assign(to: &$decks)
  }
}
