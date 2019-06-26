// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

@_functionBuilder
struct CollectionCellBuilder {
  static func buildBlock<Content: View>(_ views: Content...) -> [Content] {
    return views
  }

  static func buildBlock<D0, C0>(_ forEachCollection: ForEach<D0, C0>...) -> [C0] {
    return forEachCollection.reduce(into: []) { (result, forEach) in
      result.append(contentsOf: forEach.data.map { forEach.content($0.identifiedValue) })
    }
  }
}
