//
//  CardsOO.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import SwiftUI
import Combine

class CardsOO: ObservableObject {
  @Published private var cardIDs: CardIDs = CardIDs.empty
  
  @Published public var cards: [Card] = []
  @Published public var error: Error?
  
  private let ankiService: AnkiServiceDataPublisher
  private var cancellable: AnyCancellable?
  
  public init(ankiService: AnkiServiceDataPublisher = AnkiService()) {
    self.ankiService = ankiService
    
    
  }
  
  public func fetchCards(with deckName: String) {
    cancellable = ankiService.cardsPublisher(for: deckName)
      .decode(type: CardIDs.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] completion in
        if case .failure(let error) = completion {
          print(error)
          self.error = error
        }
      } receiveValue: { [unowned self] cardIDs in
        print(cardIDs)
        self.cardIDs = cardIDs
      }
  }
}
