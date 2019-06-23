//
//  Collection.swift
//  CollectionView
//
//  Created by Shawn Moore on 6/21/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//

import SwiftUI

struct Collection<Content> : UIViewRepresentable where Content : View {
    let content: Content?

    init() {
      self.content = nil
    }

    init(@ViewBuilder content: () -> Content) {
      self.content = content()
    }

    init<Data, ItemContent>(_ data: Data, itemContent: @escaping (Data.Element.IdentifiedValue) -> ItemContent) where Content == ForEach<Data, ItemContent>, Data : RandomAccessCollection, ItemContent : View, Data.Element : Identifiable {
      self.content = ForEach(data, content: itemContent)
    }

    func makeCoordinator() -> Collection.Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: Collection.makeLayout())
        view.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        
        context.coordinator.dataSource = Collection.configureDataSource(for: view)
        
        return view
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        // blank
    }
}

// MARK: - Layout
fileprivate extension Collection {
    static func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
        
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
    class Coordinator {
        typealias DataSourceType = UICollectionViewDiffableDataSource<Section, Int>
        
        var dataSource: DataSourceType?
        
        init(_ dataSource: DataSourceType? = nil) {
            self.dataSource = dataSource
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
