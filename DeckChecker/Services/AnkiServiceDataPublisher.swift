//
//  AnkiServiceDataPublisher.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/10.
//

import Foundation
import Combine

public protocol AnkiServiceDataPublisher {
  func decksPublisher() -> AnyPublisher<Data, URLError>
}
