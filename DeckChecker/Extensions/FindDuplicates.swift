//
//  FilterDuplicates.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/14.
//

import Combine

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
    
    public func findDuplicates2(by predicate: (Output, Output) -> Bool) -> Publishers.Sequence<[Output], Failure> {
        var p: Output?
        
        let s = self.sequence.reduce([]) { (partialResult: [Output], v) in
            defer {
                p = v
            }
            guard let p = p else {
                return partialResult
            }
            
            if predicate(p, v) {
                return partialResult + [p, v]
            } else {
                return partialResult
            }
        }
        
        return .init(sequence: s)
    }
}



