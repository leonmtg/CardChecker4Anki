//
//  CardInfos.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/11.
//

import Foundation

struct CardInfos: Decodable {
  public var cards: [Card]
  public var error: String? = nil
  
  private enum CodingKeys: String, CodingKey {
    case cards = "result"
    case error
  }
}
