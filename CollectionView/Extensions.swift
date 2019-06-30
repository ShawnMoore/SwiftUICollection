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
