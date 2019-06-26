// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

@_functionBuilder
struct CollectionCellBuilder {
  static func buildBlock<Content: View>(_ views: Content...) -> [Content] {
    return views
  }
}
