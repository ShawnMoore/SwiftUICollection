// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

struct CollectionSection<Parent, Content, Footer> : DynamicViewContent where Parent : View, Content : View, Footer : View {
    var parentView: Parent
    var footerView: Footer
    var data: [Content]

    var parentViewController: UIHostingController<Parent> {
      return UIHostingController<Parent>(rootView: parentView)
    }

    var footerViewController: UIHostingController<Footer> {
      return UIHostingController<Footer>(rootView: footerView)
    }

    var dataViewControllers: [UIHostingController<Content>] {
      return data.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
      return ViewBuilder.buildBlock(parentView,
                                    data.element(at: 0),
                                    data.element(at: 1),
                                    data.element(at: 2),
                                    data.element(at: 3),
                                    data.element(at: 4),
                                    data.element(at: 5),
                                    data.element(at: 6),
                                    data.element(at: 7),
                                    footerView)
    }

  init(header: Parent, footer: Footer, content: () -> Content) {
    self.parentView = header
    self.footerView = footer
    self.data = [content()]
  }
  
  init<Data>(header: Parent, footer: Footer, _ forEach: () -> ForEach<Data, Content>) {
    self.parentView = header
    self.footerView = footer

    let forEach = forEach()
    self.data = forEach.data.map { forEach.content($0.identifiedValue) }
  }

  init(header: Parent, footer: Footer, @CollectionBuilder content: () -> [Content]) {
    self.parentView = header
    self.footerView = footer
    self.data = content()
  }

  init<Data>(header: Parent, footer: Footer, _ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.parentView = header
    self.footerView = footer
    self.data = data.map({ itemContent($0.identifiedValue) })
  }
}

extension CollectionSection where Parent == EmptyView {
  init(footer: Footer, content: () -> Content) {
    self.init(header: EmptyView(), footer: footer, content: content)
  }

  init<Data>(footer: Footer, _ forEach: () -> ForEach<Data, Content>) {
    self.init(header: EmptyView(), footer: footer, forEach)
  }

  init(footer: Footer, @CollectionBuilder content: () -> [Content]) {
    self.init(header: EmptyView(), footer: footer, content: content)
  }

  init<Data>(footer: Footer, _ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.init(header: EmptyView(), footer: footer, data, itemContent: itemContent)
  }
}

extension CollectionSection where Footer == EmptyView {
  init(header: Parent, content: () -> Content) {
    self.init(header: header, footer: EmptyView(), content: content)
  }

  init<Data>(header: Parent, _ forEach: () -> ForEach<Data, Content>) {
    self.init(header: header, footer: EmptyView(), forEach)
  }

  init(header: Parent, @CollectionBuilder content: () -> [Content]) {
    self.init(header: header, footer: EmptyView(), content: content)
  }

  init<Data>(header: Parent, _ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.init(header: header, footer: EmptyView(), data, itemContent: itemContent)
  }
}

extension CollectionSection where Parent == EmptyView, Footer == EmptyView {
  init(content: () -> Content) {
    self.init(header: EmptyView(), footer: EmptyView(), content: content)
  }

  init<Data>(_ forEach: () -> ForEach<Data, Content>) {
    self.init(header: EmptyView(), footer: EmptyView(), forEach)
  }

  init(@CollectionBuilder content: () -> [Content]) {
    self.init(header: EmptyView(), footer: EmptyView(), content: content)
  }

  init<Data>(_ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.init(header: EmptyView(), footer: EmptyView(), data, itemContent: itemContent)
  }
}

fileprivate extension Array {
  func element(at index: Index) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }

    return self[index]
  }
}

//#if DEBUG
//struct CollectionSection_Previews : PreviewProvider {
//    static var previews: some View {
//        CollectionSection()
//    }
//}
//#endif
