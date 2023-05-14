//
//  CardsOO.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import SwiftUI
import Combine

struct ErrorForView: Error, Identifiable {
  let id = UUID()
  var message = ""
}

class CardsOO: ObservableObject {
  private var deckName: String?
    
  @Published public var cards: [Card] = []
  @Published public var errorForView: ErrorForView?
  @Published public var fetching = false
  
  private let ankiService: AnkiServiceDataPublisher
  private var cancellable: AnyCancellable?
  
  public init(ankiService: AnkiServiceDataPublisher = AnkiService()) {
    self.ankiService = ankiService
    
    $cards.combineLatest($errorForView) { (cards, error) in
      return cards.isEmpty && error == nil
    }
    .assign(to: &$fetching)
  }
  
  public func fetchCards(with deckName: String) {
    self.deckName = deckName
    
    cancellable = ankiService.cardsPublisher(for: deckName)
      .decode(type: CardIDs.self, decoder: JSONDecoder())
      .map { [unowned self] cardIDs in
        if cardIDs.ids.count > 0 {
          return self.ankiService.cardInfosPublisher(for: cardIDs.ids)
            .decode(type: CardInfos.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        } else {
          if let error = cardIDs.error {
            return Fail(error: ErrorForView(message: error))
              .eraseToAnyPublisher()
          } else {
            return Fail(error: ErrorForView(message: "Unknown Anki Error!"))
              .eraseToAnyPublisher()
          }
        }
      }
      .switchToLatest()
      .mapError { error in
        if let errorForView = error as? ErrorForView {
          return errorForView
        } else {
          return ErrorForView(message:error.localizedDescription)
        }
      }
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] completion in
        if case .failure(let error) = completion {
          self.errorForView = error
        }
      } receiveValue: { cardInfo in
        if let error = cardInfo.error {
          self.errorForView = ErrorForView(message: error)
        } else {
          self.cards = cardInfo.cards          
        }
      }
    
  }
}
