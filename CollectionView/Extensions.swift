// Copyright 2004-present Facebook. All Rights Reserved.

import UIKit

internal extension Array {
  func element(at index: Index) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }

    return self[index]
  }
}

internal extension UICollectionViewCell {
  func embed(_ view: UIView) -> UICollectionViewCell {
    view.translatesAutoresizingMaskIntoConstraints = false
    view.frame = self.frame
    self.addSubview(view)

    view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    return self
  }
}

internal extension NSCollectionLayoutSection {
  enum Layouts: RawRepresentable {
    init?(rawValue: NSCollectionLayoutSection) {
      self = Layouts.customSection(rawValue)
    }

    case list
    case squareGrid(_ amount: Int)
    case customSection(_ value: NSCollectionLayoutSection)

    var rawValue: NSCollectionLayoutSection {
      switch self {
      case .list:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        return NSCollectionLayoutSection(group: group)
      case .squareGrid(let perRow):
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/CGFloat(perRow)),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0/CGFloat(perRow)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        return NSCollectionLayoutSection(group: group)
      case .customSection(let value):
        return value
      }
    }
  }
}
