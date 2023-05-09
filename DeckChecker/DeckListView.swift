//
//  ContentView.swift
//  DeckChecker
//
//  Created by Leon on 2023/5/9.
//

import SwiftUI

struct DeckListView: View {
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
  }
}

struct DeckListView_Previews: PreviewProvider {
  static var previews: some View {
    DeckListView()
  }
}
