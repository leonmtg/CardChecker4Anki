//
//  Decks.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/10.
//

import Foundation

struct Decks: Decodable {
  public var deckNames: [String]
  public var error: String? = nil
  
  private enum CodingKeys: String, CodingKey {
    case deckNames = "result"
    case error
  }
  
  public static let emptyDecks: Decks = {
    return Decks(
      deckNames: []
    )
  }()
  
  public static let errorDecks: Decks = {
    return Decks(
      deckNames: [],
      error: "Unknown Error"
    )
  }()
}
