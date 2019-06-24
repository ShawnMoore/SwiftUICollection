//
//  Collection.swift
//  CollectionView
//
//  Created by Shawn Moore on 6/21/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//

import SwiftUI

struct Collection<Content> : UIViewRepresentable where Content : View {
    var viewControllers: [UIHostingController<Content>]

    fileprivate var padding: UIEdgeInsets?

    init() {
      self.viewControllers = []
    }

    init(@ViewBuilder content: () -> Content) {
      self.viewControllers = [UIHostingController(rootView: content())]
    }

    init<C0, C1>(@ViewBuilder content: () -> TupleView<(C0, C1)>) where C0 : View, C1 : View, Content == AnyView {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1))]
    }

    init<C0, C1, C2>(@ViewBuilder content: () -> TupleView<(C0, C1, C2)>) where C0 : View, C1 : View, C2 : View, Content == AnyView {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2))]
    }

    init<C0, C1, C2, C3>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3)>) where C0 : View, C1 : View, C2 : View, C3 : View, Content == AnyView {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3))]
    }

    init<C0, C1, C2, C3, C4>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4)>) where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, Content == AnyView {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3)),
                              UIHostingController(rootView: AnyView(content.value.4))]
    }

    init<C0, C1, C2, C3, C4, C5>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5)>) where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, Content == AnyView  {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3)),
                              UIHostingController(rootView: AnyView(content.value.4)),
                              UIHostingController(rootView: AnyView(content.value.5))]
    }

    init<C0, C1, C2, C3, C4, C5, C6>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6)>) where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, Content == AnyView  {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3)),
                              UIHostingController(rootView: AnyView(content.value.4)),
                              UIHostingController(rootView: AnyView(content.value.5)),
                              UIHostingController(rootView: AnyView(content.value.6))]
    }

    init<C0, C1, C2, C3, C4, C5, C6, C7>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7)>) where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, Content == AnyView  {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3)),
                              UIHostingController(rootView: AnyView(content.value.4)),
                              UIHostingController(rootView: AnyView(content.value.5)),
                              UIHostingController(rootView: AnyView(content.value.6)),
                              UIHostingController(rootView: AnyView(content.value.7))]
    }

    init<C0, C1, C2, C3, C4, C5, C6, C7, C8>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8)>) where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, Content == AnyView  {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3)),
                              UIHostingController(rootView: AnyView(content.value.4)),
                              UIHostingController(rootView: AnyView(content.value.5)),
                              UIHostingController(rootView: AnyView(content.value.6)),
                              UIHostingController(rootView: AnyView(content.value.7)),
                              UIHostingController(rootView: AnyView(content.value.8))]
    }

    init<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>) where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View, Content == AnyView  {
      let content = content()
      self.viewControllers = [UIHostingController(rootView: AnyView(content.value.0)),
                              UIHostingController(rootView: AnyView(content.value.1)),
                              UIHostingController(rootView: AnyView(content.value.2)),
                              UIHostingController(rootView: AnyView(content.value.3)),
                              UIHostingController(rootView: AnyView(content.value.4)),
                              UIHostingController(rootView: AnyView(content.value.5)),
                              UIHostingController(rootView: AnyView(content.value.6)),
                              UIHostingController(rootView: AnyView(content.value.7)),
                              UIHostingController(rootView: AnyView(content.value.8)),
                              UIHostingController(rootView: AnyView(content.value.9))]
    }

    init<Data>(_ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> Content) where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
      self.viewControllers = data.reduce(into: [], { (result, element) in
        result.append(UIHostingController(rootView: itemContent(element.identifiedValue)))
      })
    }

    func makeCoordinator() -> Collection.Coordinator<Content> {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: Collection.makeLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        let delegate = Collection.LayoutInformation(items: viewControllers, padding: padding)
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
        snapshot.appendItems(viewControllers)
        dataSource.apply(snapshot, animatingDifferences: false)

        context.coordinator.dataSource = dataSource
        context.coordinator.delegate = delegate
        
        return view
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        // blank
    }
}

// MARK: - Layout
fileprivate extension Collection {
    static func makeLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewFlowLayout()
      layout.minimumInteritemSpacing = 0;
      layout.minimumLineSpacing = 0;

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
    let padding: UIEdgeInsets

    override init() {
      self.sizes = []
      self.padding = .zero
    }

    init<Content>(items: [UIHostingController<Content>], padding: UIEdgeInsets? = nil) where Content : View {
      self.sizes = items.reduce(into: [], { (result, hostingController) in
        result.append(hostingController.sizeThatFits(in: UIScreen.main.bounds.size))
      })
      self.padding = padding ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return sizes[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return padding
    }
  }
}

//// MARK: - Padding
//extension Collection {
//  mutating func padding(_ length: Length) -> Collection<Content> {
//    self.padding = UIEdgeInsets(top: length, left: length, bottom: length, right: length)
//    return self
//  }
//
//  mutating func padding(_ edges: Edge.Set = .all, _ length: Length? = nil) -> Collection<Content> {
//    let systemPadding: Length = 4
//    let padding = length ?? systemPadding
//    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//    if edges == .top || edges == .all || edges == .vertical {
//      insets.top = padding
//    }
//
//    if edges == .bottom || edges == .all || edges == .vertical {
//      insets.bottom = padding
//    }
//
//    if edges == .leading || edges == .all || edges == .horizontal {
//      insets.left = padding
//    }
//
//    if edges == .trailing || edges == .all || edges == .horizontal {
//      insets.right = padding
//    }
//
//    self.padding = insets
//    return self
//  }
//}

// MARK: - Data Source
extension Collection {
    enum Section {
        case main
    }
    
    fileprivate static func configureDataSource(for view: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Int> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: view) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.reuseIdentifier,
                for: indexPath) as? TextCell else { fatalError("Could not create new cell") }
            
            // Populate the cell with our item description.
            cell.label.text = "\(identifier)"
            cell.contentView.backgroundColor = .red
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
            
            // Return the cell.
            return cell
        }
        
        // initial data
        let snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot, animatingDifferences: false)
        
        return dataSource
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
        Collection<Text>()
    }
}
#endif

//extension UIHostingController {
//  func build<Data, ItemContent>(from view: ForEach<Data, ItemContent>) -> [UIHostingController<AnyView>]  where Data : RandomAccessCollection, ItemContent : View, Data.Element : Identifiable {
//    return view.data.reduce(into: []) { (result, element) in
//      result.append(UIHostingController<AnyView>(rootView: AnyView(view.content(element.identifiedValue))))
//    }
//  }
//
//  func build<ItemContent>(from view: ItemContent) -> [UIHostingController<AnyView>] {
//    return [UIHostingController<AnyView>(rootView: AnyView(view)]
//  }
//}
