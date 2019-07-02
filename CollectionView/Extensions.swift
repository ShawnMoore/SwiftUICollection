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

internal extension NSCollectionLayoutGroup {
  enum Layouts: RawRepresentable {
    case list
    case squareGrid(_ amount: Int)
    case nested
    case news(_ count: Int)

    init?(rawValue: NSCollectionLayoutGroup) {
      return nil
    }

    var rawValue: NSCollectionLayoutGroup {
      switch self {
      case .list:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                  subitems: [item])
      case .squareGrid(let perRow):
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/CGFloat(perRow)),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0/CGFloat(perRow)))
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                  subitems: [item])
      case .nested:
        let leadingItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                             heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let trailingItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(0.3)))
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let trailingGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                             heightDimension: .fractionalHeight(1.0)),
          subitem: trailingItem, count: 2)

        return NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(0.4)),
          subitems: [leadingItem, trailingGroup])
      case .news(let count):
        let subGroups: [NSCollectionLayoutGroup] = {
          var itemCount = count
          var groups: [NSCollectionLayoutGroup] = []

          while itemCount > 0 {
            let rowCount = Int.random(in: 1..<3)

            if itemCount == 1 || rowCount == 1 {
              itemCount -= 1
              groups.append(Layouts.list.rawValue)
            } else /*if rowCount == 2*/ {
              itemCount -= 2
              groups.append(Layouts.squareGrid(2).rawValue)
            }
          }

          return groups
        }()

        return NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(UIScreen.main.bounds.size.height)),
          subitems: subGroups)
      }
    }
  }
}

internal extension NSCollectionLayoutSection {
  enum Layouts: RawRepresentable {
    init?(rawValue: NSCollectionLayoutSection) {
      self = Layouts.customSection(rawValue)
    }

    case list
    case squareGrid(_ amount: Int)
    case nested
    case customSection(_ value: NSCollectionLayoutSection)

    var rawValue: NSCollectionLayoutSection {
      switch self {
      case .list:
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup.Layouts.list.rawValue)
      case .squareGrid(let perRow):
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup.Layouts.squareGrid(perRow).rawValue)
      case .nested:
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup.Layouts.nested.rawValue)
      case .customSection(let value):
        return value
      }
    }
  }
}
