//
//  Decks.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/10.
//

import Foundation

struct Decks: Decodable {
  public var result: [String]
  public var error: String? = nil
  
  public static let emptyDecks: Decks = {
    return Decks(
      result: []
    )
  }()
  
  public static let errorDecks: Decks = {
    return Decks(
      result: [],
      error: "Unknown Error"
    )
  }()
}
