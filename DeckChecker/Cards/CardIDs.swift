//
//  CardIDs.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import Foundation

struct CardIDs: Decodable {
  public var cardIDs: [Int]
  public var error: String? = nil
  
  public static let empty: CardIDs = {
    return CardIDs(
      cardIDs: []
    )
  }()
  
  private enum CodingKeys: String, CodingKey {
    case cardIDs = "result"
    case error
  }
}
