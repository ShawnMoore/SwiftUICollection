//
//  Collection.swift
//  CollectionView
//
//  Created by Shawn Moore on 6/21/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//

import SwiftUI

struct Collection<Parent, Footer, Content> : UIViewRepresentable where Parent : View, Footer : View, Content : View {
    fileprivate var views: [CollectionSection<Parent, Footer, Content>]
    fileprivate var insets: UIEdgeInsets?
    fileprivate var spacing: Length?
    fileprivate var rowSpacing: Length?

    fileprivate init(views: [CollectionSection<Parent, Footer, Content>] = [],
                     insets: UIEdgeInsets? = nil,
                     spacing: Length? = nil,
                     rowSpacing: Length? = nil) {
      self.views = views
      self.insets = insets
      self.spacing = spacing
      self.rowSpacing = rowSpacing
    }

    fileprivate func modify(views: [CollectionSection<Parent, Footer, Content>]? = nil,
                            insets: UIEdgeInsets? = nil,
                            spacing: Length? = nil,
                            rowSpacing: Length? = nil) -> Self {
      return Self.init(views: views ?? self.views, insets: insets ?? self.insets, spacing: spacing ?? self.spacing, rowSpacing: rowSpacing ?? self.rowSpacing)
    }

    init() {
      self.views = []
    }

    init(@CollectionBuilder content: () -> [CollectionSection<Parent, Footer, Content>]) {
      self.views = content()
    }

    init<Data>(_ information: (header: Parent, footer: Footer, Data)..., itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
        self.views = information.map({ CollectionSection(header: $0.header, footer: $0.footer, content: $0.2.map { itemContent($0.identifiedValue) }) })
    }
  
    func makeCoordinator() -> Collection.Coordinator<Content> {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let view = SizeableCollectionView(frame: .zero, collectionViewLayout: makeLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        let dataSource = UICollectionViewDiffableDataSource<Int, UIHostingController<Content>>(collectionView: view) {
          (collectionView: UICollectionView,
          indexPath: IndexPath,
          hostingController: UIHostingController<Content>) -> UICollectionViewCell? in

          // Return the cell.
          return collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath).embed(hostingController.view)
        }

        // initial data
        let snapshot = NSDiffableDataSourceSnapshot<Int, UIHostingController<Content>>()

        snapshot.appendSections(Array(self.views.startIndex..<self.views.endIndex))

        for (index, section) in self.views.enumerated() {
          snapshot.appendItems(section.views.content, toSection: index)
        }
      
        dataSource.apply(snapshot, animatingDifferences: false)

        context.coordinator.dataSource = dataSource
        
        return view
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        // blank
    }
}

extension Collection where Parent == EmptyView {
  init<Data>(_ information: (footer: Footer, Data)..., itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.views = information.map({ CollectionSection(header: EmptyView(), footer: $0.footer, content: $0.1.map { itemContent($0.identifiedValue) }) })
  }
}

extension Collection where Footer == EmptyView {
  init<Data>(_ information: (header: Parent, Data)..., itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.views = information.map({ CollectionSection(header: $0.header, footer: EmptyView(), content: $0.1.map { itemContent($0.identifiedValue) }) })
  }
}

extension Collection where Parent == EmptyView, Footer == EmptyView {
  init<Data>(_ data: Data..., itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
    self.views = data.map({ CollectionSection(header: EmptyView(), footer: EmptyView(), content: $0.map { itemContent($0.identifiedValue) }) })
  }
}

// MARK: - Layout
fileprivate extension Collection {
    func makeLayout() -> UICollectionViewLayout {
      return UICollectionViewCompositionalLayout { (section, environment) -> NSCollectionLayoutSection? in
        return self.views[section].sectionLayout
      }
    }
}

// MARK: - insets
extension Collection {
  func insets(_ length: Length) -> Collection<Parent, Footer, Content> {
    return self.modify(insets: UIEdgeInsets(top: length, left: length, bottom: length, right: length))
  }

  func insets(_ edges: Edge.Set = .all, _ length: Length? = nil) -> Collection<Parent, Footer, Content> {
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

// MARK: - Spacing
extension Collection {
  func spacing(_ length: Length? = nil) -> Collection<Parent, Footer, Content> {
    return self.modify(spacing: length ?? 4)
  }

  func rowSpacing(_ length: Length? = nil) -> Collection<Parent, Footer, Content> {
    return self.modify(rowSpacing: length ?? 4)
  }
}

// MARK: - Coordinator
extension Collection {
    class Coordinator<Content: View> {
        typealias DataSourceType = UICollectionViewDiffableDataSource<Int, UIHostingController<Content>>
        
        var dataSource: DataSourceType?
        
        init(dataSource: DataSourceType? = nil) {
            self.dataSource = dataSource
        }
    }
}

// MARK: - Previews
#if DEBUG
struct Collection_Previews : PreviewProvider {
    static var previews: some View {
        Collection<AnyView, AnyView, Text>()
    }
}
#endif
