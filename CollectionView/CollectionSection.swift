// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

struct CollectionSection<Parent, Footer, Content> : DynamicViewContent where Parent : View, Footer : View, Content : View {
    // MARK: - Properties
    // MARK: Views
    fileprivate(set) var header: Parent
    fileprivate(set) var footer: Footer
    fileprivate(set) var data: [Content]

    // MARK: Mutable
    fileprivate(set) var sectionLayout = NSCollectionLayoutSection.Layouts.squareGrid(3).rawValue
    fileprivate(set) var insets: UIEdgeInsets?

    var views: CollectionSectionViews<Parent, Footer, Content> {
      return CollectionSectionViews(section: self)
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
       data: [Content],
       insets: UIEdgeInsets?,
       sectionLayout: NSCollectionLayoutSection) {
    self.header = header
    self.footer = footer
    self.data = data
    self.insets = insets
    self.sectionLayout = sectionLayout
  }

  fileprivate func modify(header: Parent? = nil,
                          footer: Footer? = nil,
                          data: [Content]? = nil,
                          insets: UIEdgeInsets? = nil,
                          sectionLayout: NSCollectionLayoutSection? = nil) -> Self {
    return Self.init(header: header ?? self.header, footer: footer ?? self.footer, data: data ?? self.data, insets: insets ?? self.insets, sectionLayout: sectionLayout ?? self.sectionLayout)
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

// MARK: - insets
extension CollectionSection {
  func insets(_ length: Length) -> Self {
    return self.modify(insets: UIEdgeInsets(top: length, left: length, bottom: length, right: length))
  }

  func insets(_ edges: Edge.Set = .all, _ length: Length? = nil) -> Self {
    let systeminsets: Length = 4
    let insetsValue = length ?? systeminsets
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    if edges == .top || edges == .all || edges == .vertical {
      insets.top = insetsValue
    }

    if edges == .bottom || edges == .all || edges == .vertical {
      insets.bottom = insetsValue
    }

    if edges == .leading || edges == .all || edges == .horizontal {
      insets.left = insetsValue
    }

    if edges == .trailing || edges == .all || edges == .horizontal {
      insets.right = insetsValue
    }

    return self.modify(insets: insets)
  }
}

// MARK: - Layout
extension CollectionSection {
  func sectionLayout(with group: NSCollectionLayoutGroup) -> Self {
    return self.modify(sectionLayout: NSCollectionLayoutSection(group: group))
  }

  func verticalSectionLayout(width: NSCollectionLayoutDimension = .fractionalWidth(1.0), height: NSCollectionLayoutDimension, with subitems: [NSCollectionLayoutItem]) -> Self {
    return
      self.sectionLayout(with: NSCollectionLayoutGroup.vertical(
                               layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height),
                               subitems: subitems))
  }

  func horizontalSectionLayout(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension = .fractionalWidth(1.0), with subitems: [NSCollectionLayoutItem]) -> Self {
    return
      self.sectionLayout(with: NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height),
        subitems: subitems))
  }
}

//#if DEBUG
//struct CollectionSection_Previews : PreviewProvider {
//    static var previews: some View {
//        CollectionSection()
//    }
//}
//#endif
