//
//  AnkiService.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/10.
//

import Foundation
import Combine

public struct AnkiService {
  private var urlComponents: URLComponents {
    var components = URLComponents()
    components.scheme = "http"
    components.host = "127.0.0.1"
    components.port = 8765
    
    return components
  }
  
  private var decksUrlRequest: URLRequest {
    let json: [String: Any] = [
      "action": "deckNames",
      "version": 6
    ]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    let url = urlComponents.url!
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.httpBody = jsonData
    
    return request
  }
  
  private func cardsUrlRequest(deckName: String) -> URLRequest {
    let json: [String: Any] = [
      "action": "findCards",
      "version": 6,
      "params": [
        "query": "deck:\(deckName)"
      ]
    ]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    let url = urlComponents.url!
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.httpBody = jsonData
    
    return request
  }
}

extension AnkiService: AnkiServiceDataPublisher {
  public func decksPublisher() -> AnyPublisher<Data, URLError> {
    URLSession.shared
      .dataTaskPublisher(for: decksUrlRequest)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .map(\.data)
      .eraseToAnyPublisher()
  }
  
  public func cardsPublisher(for deckName: String) -> AnyPublisher<Data, URLError> {
    URLSession.shared
      .dataTaskPublisher(for: self.cardsUrlRequest(deckName: deckName))
      .subscribe(on: DispatchQueue.global(qos: .default))
      .map(\.data)
      .eraseToAnyPublisher()
  }
}
