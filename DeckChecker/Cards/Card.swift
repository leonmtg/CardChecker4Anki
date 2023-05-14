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
  
  var question: String
  var answer: String
  
  var fieldOrder: Int
  var fields: [String:Field]
  
  private enum CodingKeys: String, CodingKey {
    case id = "cardId"
    case deckName
    case modelName
    case question
    case answer
    case fieldOrder
    case fields
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.deckName = try container.decode(String.self, forKey: .deckName)
    self.modelName = try container.decode(String.self, forKey: .modelName)
    self.question = try container.decode(String.self, forKey: .question)
    self.answer = try container.decode(String.self, forKey: .answer)
    
    let fieldOrder = try container.decode(Int.self, forKey: .fieldOrder)
    self.fieldOrder = fieldOrder
    
    let fields = try container.decode([String : Field].self, forKey: .fields)
    self.fields = fields
    
    if let kv = fields.first(where: { $1.order == fieldOrder }) {
      self.orderFieldValue = kv.value.value
    } else {
      self.orderFieldValue = ""
    }
  }
  
  var orderFieldValue: String
}
