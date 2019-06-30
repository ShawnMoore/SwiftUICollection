// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

struct CollectionSection<Parent, Footer, Content> : DynamicViewContent where Parent : View, Footer : View, Content : View {
    fileprivate(set) var header: Parent
    fileprivate(set) var footer: Footer
    fileprivate(set) var data: [Content]

    var views: CollectionSectionViews<Parent, Footer, Content> {
      return CollectionSectionViews(section: self)
    }

    var layout: CollectionSectionLayout<Parent, Footer, Content> {
      return CollectionSectionLayout(views: self.views)
    }

    var body: some View {
      return ViewBuilder.buildBlock(header,
                                    data.element(at: 0),
                                    data.element(at: 1),
                                    data.element(at: 2),
                                    data.element(at: 3),
                                    data.element(at: 4),
                                    data.element(at: 5),
                                    data.element(at: 6),
                                    data.element(at: 7),
                                    footer)
    }

  init(header: Parent,
       footer: Footer,
       data: [Content]) {
    self.header = header
    self.footer = footer
    self.data = data
  }

  fileprivate func modify(header: Parent?,
                          footer: Footer?,
                          data: [Content]?) -> Self {
    return Self.init(header: header ?? self.header, footer: footer ?? self.footer, data: data ?? self.data)
  }

  init(header: Parent, footer: Footer, @CollectionSectionBuilder content: () -> [Content]) {
    self.header = header
    self.footer = footer
    self.data = content()
  }

  init(header: Parent, footer: Footer, content: [Content]) {
    self.header = header
    self.footer = footer
    self.data = content
  }

  init<Data>(_ data: Data, header: Parent, footer: Footer, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.header = header
    self.footer = footer
    self.data = data.map({ itemContent($0.identifiedValue) })
  }
}

extension CollectionSection where Parent == EmptyView {
  init(footer: Footer, @CollectionSectionBuilder content: () -> [Content]) {
    self.init(header: EmptyView(), footer: footer, content: content)
  }

  init(footer: Footer, content: [Content]) {
    self.init(header: EmptyView(), footer: footer, content: content)
  }

  init<Data>(_ data: Data, footer: Footer, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.init(data, header: EmptyView(), footer: footer, itemContent: itemContent)
  }
}

extension CollectionSection where Footer == EmptyView {
  init(header: Parent, @CollectionSectionBuilder content: () -> [Content]) {
    self.init(header: header, footer: EmptyView(), content: content)
  }

  init(header: Parent, content: [Content]) {
    self.init(header: header, footer: EmptyView(), content: content)
  }

  init<Data>(_ data: Data, header: Parent, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.init(data, header: header, footer: EmptyView(), itemContent: itemContent)
  }
}

extension CollectionSection where Parent == EmptyView, Footer == EmptyView {
  init(@CollectionSectionBuilder content: () -> [Content]) {
    self.init(header: EmptyView(), footer: EmptyView(), content: content)
  }

  init(content: [Content]) {
    self.init(header: EmptyView(), footer: EmptyView(), content: content)
  }

  init<Data>(_ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.init(data, header: EmptyView(), footer: EmptyView(), itemContent: itemContent)
  }
}

// MARK: - UIViews
struct CollectionSectionViews<Parent, Footer, Content> where Parent : View, Footer : View, Content : View {
  let parent: UIHostingController<Parent>
  let content: [UIHostingController<Content>]
  let footer: UIHostingController<Footer>

  init(section: CollectionSection<Parent, Footer, Content>) {
    self.parent = UIHostingController(rootView: section.header)
    self.content = section.data.map({ UIHostingController(rootView: $0) })
    self.footer = UIHostingController(rootView: section.footer)
  }
}

// MARK: - Layout
struct CollectionSectionLayout<Parent, Footer, Content> where Parent : View, Footer : View, Content : View {
  let parentSize: CGSize
  let contentSizes: [CGSize]
  let footerSize: CGSize

  init(views: CollectionSectionViews<Parent, Footer, Content>) {
    self.parentSize = views.parent.sizeThatFits(in: UIScreen.main.bounds.size)
    self.contentSizes = views.content.map({ $0.sizeThatFits(in: UIScreen.main.bounds.size) })
    self.footerSize = views.footer.sizeThatFits(in: UIScreen.main.bounds.size)
  }
}

//#if DEBUG
//struct CollectionSection_Previews : PreviewProvider {
//    static var previews: some View {
//        CollectionSection()
//    }
//}
//#endif
