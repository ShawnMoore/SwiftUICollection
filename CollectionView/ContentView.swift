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
    let favoriteRestaurants = [
      Restaurant(name: "Joe's Original"),
      Restaurant(name: "The Real Joe's Original"),
      Restaurant(name: "Original Joe's")
    ]

    let hatedRestaurants = [
      Restaurant(name: "Bob's Original"),
      Restaurant(name: "The Real Bob's Original"),
      Restaurant(name: "Original Bob's")
    ]

    var body: some View {
      Collection {
        CollectionCellBuilder.buildBlock(
          ForEach(favoriteRestaurants) { (restaurant) -> Text in
            Text(restaurant.name)
          },
          ForEach(hatedRestaurants) { (restaurant) -> Text in
            Text(restaurant.name)
          }
        )
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
