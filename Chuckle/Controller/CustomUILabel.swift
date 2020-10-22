//
//  CustomUILabel.swift
//  ColourMatch
//
//  Created by Murray Goodwin on 05/06/2020.
//  Copyright © 2020 Murray Goodwin. All rights reserved.
//

import UIKit

final class CustomUILabel: UILabel {
  
  @IBInspectable var topInset: CGFloat = 0.0
  @IBInspectable var bottomInset: CGFloat = 0.0
  @IBInspectable var leftInset: CGFloat = 0.0
  @IBInspectable var rightInset: CGFloat = 5.0
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      var contentSize = super.intrinsicContentSize
      contentSize.height += topInset + bottomInset
      contentSize.width += leftInset + rightInset
      return contentSize
    }
  }
}
