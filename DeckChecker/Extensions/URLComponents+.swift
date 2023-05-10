//
//  URLComponents+.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/10.
//

import Foundation

extension URLComponents {
  mutating func setQueryItems(with parameters: [String:String]) {
    self.queryItems = parameters.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }
  }
}
