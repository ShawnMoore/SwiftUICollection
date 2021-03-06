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

    fileprivate init(views: [CollectionSection<Parent, Footer, Content>] = []) {
      self.views = views
    }

    fileprivate func modify(views: [CollectionSection<Parent, Footer, Content>]?) -> Self {
      return Self.init(views: views ?? self.views)
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
        view.register(UICollectionViewCell.self, forSupplementaryViewOfKind: "section-header-element-kind", withReuseIdentifier: "supplementary")
        view.register(UICollectionViewCell.self, forSupplementaryViewOfKind: "section-footer-element-kind", withReuseIdentifier: "supplementary")

        let dataSource = UICollectionViewDiffableDataSource<Int, UIHostingController<Content>>(collectionView: view) {
          (collectionView: UICollectionView,
          indexPath: IndexPath,
          hostingController: UIHostingController<Content>) -> UICollectionViewCell? in

          // Return the cell.
          return collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath).embed(hostingController.view)
        }

        dataSource.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath) -> UICollectionReusableView? in

          let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "supplementary", for: indexPath)
          let sectionView = self.views[indexPath.section].views
          return supplementaryView.embed( kind == "section-header-element-kind" ? sectionView.parent.view : sectionView.footer.view)
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

extension Collection {
  func layout(group: NSCollectionLayoutGroup, for sectionIndex: Int? = nil) -> Self {
    if let sectionIndex = sectionIndex {
      var views = self.views

      if let view = views.element(at: sectionIndex) {
        views[sectionIndex] = view.sectionLayout(with: group)
      }

      return self.modify(views: views)
    } else {
      return self.modify(views: self.views.map { (section) -> CollectionSection<Parent, Footer, Content> in
        section.sectionLayout(with: group)
      })
    }
  }

  func header(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, pinned: Bool = false, for sectionIndex: Int? = nil) -> Self {
    if let sectionIndex = sectionIndex {
      var views = self.views

      if let view = views.element(at: sectionIndex) {
        views[sectionIndex] = view.sectionHeader(width: width, height: height, pinned: pinned)
      }

      return self.modify(views: views)
    } else {
      return self.modify(views: self.views.map { (section) -> CollectionSection<Parent, Footer, Content> in
        section.sectionHeader(width: width, height: height, pinned: pinned)
      })
    }
  }

  func footer(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, for sectionIndex: Int? = nil) -> Self {
    if let sectionIndex = sectionIndex {
      var views = self.views

      if let view = views.element(at: sectionIndex) {
        views[sectionIndex] = view.sectionFooter(width: width, height: height)
      }

      return self.modify(views: views)
    } else {
      return self.modify(views: self.views.map { (section) -> CollectionSection<Parent, Footer, Content> in
        section.sectionFooter(width: width, height: height)
      })
    }
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
