// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

struct CollectionGroup<Content> : DynamicViewContent where Content : View {
  var data: [Content]

  var dataViewControllers: [UIHostingController<Content>] {
    return data.map { UIHostingController(rootView: $0) }
  }

  var body: some View {
    return ViewBuilder.buildBlock(data.element(at: 0),
                                  data.element(at: 1),
                                  data.element(at: 2),
                                  data.element(at: 3),
                                  data.element(at: 4),
                                  data.element(at: 5),
                                  data.element(at: 6),
                                  data.element(at: 7),
                                  data.element(at: 8),
                                  data.element(at: 9))
  }

  init(@CollectionGroupBuilder content: () -> [Content]) {
    self.data = content()
  }

  init(content: [Content]) {
    self.data = content
  }

  init<Data>(_ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.data = data.map({ itemContent($0.identifiedValue) })
  }
}

//#if DEBUG
//struct CollectionGroup_Previews : PreviewProvider {
//    static var previews: some View {
//        CollectionGroup()
//    }
//}
//#endif
