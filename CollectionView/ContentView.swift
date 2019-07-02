//
//  ContentView.swift
//  CollectionView
//
//  Created by Shawn Moore on 6/21/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
      Collection(Array(0...93)) {
        Text("\($0)")
      }.layout(group: NSCollectionLayoutGroup.Layouts.news(93).rawValue)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
