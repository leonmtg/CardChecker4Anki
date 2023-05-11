//
//  CardsOO.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import SwiftUI
import Combine

struct AnkiError: Error {
  var message = ""
}

class CardsOO: ObservableObject {
  private var deckName: String?
  
  @Published private var cardIDs: CardIDs = CardIDs.empty
  
  @Published public var cards: [Card] = []
  @Published public var error: Error?
  
  @Published public var fetching = false
  
  private let ankiService: AnkiServiceDataPublisher
  
  private var cancellable: AnyCancellable?
  
  public init(ankiService: AnkiServiceDataPublisher = AnkiService()) {
    self.ankiService = ankiService
    
    $cards.combineLatest($error) { (cards, error) in
      return cards.isEmpty && error == nil
    }
    .assign(to: &$fetching)
  }
  
  public func fetchCards(with deckName: String) {
    self.deckName = deckName
    
    cancellable = ankiService.cardsPublisher(for: deckName)
      .decode(type: CardIDs.self, decoder: JSONDecoder())
      .mapError { $0 as Error }
      .flatMap { [unowned self] cardIDs -> AnyPublisher<CardInfos, Error> in
        self.ankiService.cardInfosPublisher(for: cardIDs.ids)
          .decode(type: CardInfos.self, decoder: JSONDecoder())
          .eraseToAnyPublisher()
        
      }
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] completion in
        if case .failure(let error) = completion {
          print(error)
          self.error = error
        }
      } receiveValue: { cardInfo in
        if let error = cardInfo.error {
          self.error = AnkiError(message: error)
        } else {
          self.cards = cardInfo.cards
          print(self.cards.first!)
        }
      }
  }
}
