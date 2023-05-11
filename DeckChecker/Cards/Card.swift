//
//  Card.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import Foundation

struct Card: Decodable, Identifiable {
  var id: Int
  
  var deckName: String
  var modelName: String
  
  private enum CodingKeys: String, CodingKey {
    case id = "cardId"
    case deckName
    case modelName
  }
}
