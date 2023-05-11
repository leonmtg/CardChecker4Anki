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
  
  private let ankiService: AnkiServiceDataPublisher
  
  private var fechIds: AnyCancellable?
  private var invoke: AnyCancellable?
  private var fetchInfos: AnyCancellable?
  
  public init(ankiService: AnkiServiceDataPublisher = AnkiService()) {
    self.ankiService = ankiService
    
    self.invoke = $cardIDs
      .sink { [unowned self] cardIDs in
        self.fetchCardInfos(cardIDs: cardIDs)
      }
  }
  
  public func fetchCards(with deckName: String) {
    self.deckName = deckName
    
    fechIds = ankiService.cardsPublisher(for: deckName)
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
  
  private func fetchCardInfos(cardIDs: CardIDs) {
    guard cardIDs.ids.count > 0 else {
      return
    }
    
    fetchInfos = ankiService.cardInfosPublisher(for: cardIDs.ids)
      .decode(type: CardInfos.self, decoder: JSONDecoder())
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
