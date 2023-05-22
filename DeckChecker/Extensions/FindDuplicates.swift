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
    
    let s = self.sequence.compactMap { v -> [String]? in
      defer {
        p = v
      }
      guard let p = p else {
        return nil
      }

      return v == p ? [p, v] : nil
    }.flatMap { $0 }
    
    return .init(sequence: s)
  }
}

extension Publishers.Sequence {
  public func findDuplicates(by predicate: (Output, Output) -> Bool) -> Publishers.Sequence<[Output], Failure> {
    var p: Output?
    
    let s = self.sequence.compactMap { v -> [Output]? in
      defer {
        p = v
      }
      guard let p = p else {
        return nil
      }
      
      return predicate(p, v) ? [p, v] : nil
    }.flatMap { $0 }
    
    return .init(sequence: s)
  }
}
