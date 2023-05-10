//
//  DecksView.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/9.
//

import SwiftUI

struct DecksView: View {
  @StateObject var decksOO = DecksOO()
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
    }
    .padding()
    .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity,
           minHeight: 300, idealHeight: 400, maxHeight: .infinity)
    .onAppear {
      decksOO.fetchDecks()
    }
  }
}

struct DecksView_Previews: PreviewProvider {
  static var previews: some View {
    DecksView()
  }
}
