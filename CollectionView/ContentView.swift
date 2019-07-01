//
//  ContentView.swift
//  CollectionView
//
//  Created by Shawn Moore on 6/21/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//

import SwiftUI

struct Restaurant: Identifiable {
  var id = UUID()
  var name: String
}

struct ContentView : View {
    var body: some View {
      Collection((header: Text("Favorite"), Array(0...94)),
                 (header: Text("Hated"), Array(0...92))) {
                  Text("\($0)")
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
