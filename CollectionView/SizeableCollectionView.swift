// Copyright 2004-present Facebook. All Rights Reserved.

import UIKit

class SizeableCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  fileprivate var oldBounds: CGRect

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    self.oldBounds = frame

    super.init(frame: frame, collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    // NOTE: super.layoutSubviews hits an infinite loop when bounds is zero
    guard self.bounds != .zero else {
      return
    }

    super.layoutSubviews()

    if self.bounds != oldBounds {
      self.collectionViewLayout.invalidateLayout()
      self.oldBounds = self.bounds
    }
  }
}
