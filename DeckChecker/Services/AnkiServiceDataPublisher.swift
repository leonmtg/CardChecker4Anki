//
//  AnkiServiceDataPublisher.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/10.
//

import Foundation
import Combine

public enum UrlResponseErrors: String, Error {
  case unknown = "Response wasn't recognized"
  case clientError = "Problem getting the information"
  case serverError = "Problem with the server"
  case decodeError = "Problem reading the returned data"
}

public protocol AnkiServiceDataPublisher {
  func decksPublisher() -> AnyPublisher<Data, URLError>
  func cardsPublisher(for deckName: String) -> AnyPublisher<Data, URLError>
}
