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
      let first = Restaurant(name: "Joe's Original")
      let second = Restaurant(name: "The Real Joe's Original")
      let third = Restaurant(name: "Original Joe's")
      let restaurants = [first, second, third]

      return Collection(restaurants) { restaurant in
        Text("\(restaurant.name)")
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
