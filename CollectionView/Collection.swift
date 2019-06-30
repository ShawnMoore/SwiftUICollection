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
                            rowSpacing: Length? = nil) -> Collection<Parent, Footer, Content> {
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
        let view = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        let viewControllers: [UIHostingController<Content>] = self.views.reduce(into: []) { (result, section) in
          result.append(contentsOf: section.dataViewControllers)
        }

        let delegate = Collection.LayoutInformation(items: viewControllers, insets: insets)
        view.delegate = delegate

        let dataSource = UICollectionViewDiffableDataSource<Section, UIHostingController<Content>>(collectionView: view) {
          (collectionView: UICollectionView,
          indexPath: IndexPath,
          hostingController: UIHostingController<Content>) -> UICollectionViewCell? in

          // Get a cell of the desired kind.
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath)

          // Populate the cell with our item description.
          hostingController.view.translatesAutoresizingMaskIntoConstraints = false
          hostingController.view.frame = cell.frame
          cell.addSubview(hostingController.view)

          hostingController.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
          hostingController.view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
          hostingController.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
          hostingController.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true

          // Return the cell.
          return cell
        }

        // initial data
        let snapshot = NSDiffableDataSourceSnapshot<Section, UIHostingController<Content>>()

        snapshot.appendSections([.main])
        snapshot.appendItems(viewControllers, toSection: .main)
      
        dataSource.apply(snapshot, animatingDifferences: false)

        context.coordinator.dataSource = dataSource
        context.coordinator.delegate = delegate
        
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
      let layout = UICollectionViewFlowLayout()
      layout.minimumInteritemSpacing = self.spacing ?? 0;
      layout.minimumLineSpacing = self.rowSpacing ?? 0;

      return layout

      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalWidth(0.2))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])

      return UICollectionViewCompositionalLayout(section: NSCollectionLayoutSection(group: group))
    }
}

extension Collection {
  class LayoutInformation: NSObject, UICollectionViewDelegateFlowLayout {
    let sizes: [CGSize]
    let insets: UIEdgeInsets

    override init() {
      self.sizes = []
      self.insets = .zero
    }

    init<Content>(items: [UIHostingController<Content>], insets: UIEdgeInsets? = nil) where Content : View {
      self.sizes = items.reduce(into: [], { (result, hostingController) in
        result.append(hostingController.sizeThatFits(in: UIScreen.main.bounds.size))
      })
      self.insets = insets ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return sizes[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return insets
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

// MARK: - Data Source
extension Collection {
    enum Section {
        case main
    }
}

// MARK: - Coordinator
extension Collection {
    class Coordinator<Content: View> {
        typealias DataSourceType = UICollectionViewDiffableDataSource<Section, UIHostingController<Content>>
        
        var dataSource: DataSourceType?
        var delegate: Collection.LayoutInformation?
        
        init(dataSource: DataSourceType? = nil, delegate: Collection.LayoutInformation? = nil) {
            self.dataSource = dataSource
            self.delegate = delegate
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
