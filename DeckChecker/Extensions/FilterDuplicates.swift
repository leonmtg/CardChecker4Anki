//
//  FilterDuplicates.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/14.
//

import Combine

extension Publishers.Sequence where Elements.Element == String {
  public func findDuplicates() -> Publishers.Sequence<[Output], Failure> {
    var p: String?
    
    let s = self.sequence.compactMap { v -> String? in
      defer {
        p = v
      }
      guard let p = p else {
        return nil
      }

      return v == p ? v : nil
    }
    
    return .init(sequence: s)
  }
}
