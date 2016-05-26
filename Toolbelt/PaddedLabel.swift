//
//  PaddedLabel.swift
//  Playerbook
//
//  Created by Chris Chares on 4/4/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

@IBDesignable
class PaddedLabel : UILabel {
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var topPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var bottomPadding: CGFloat = 0

    
    override func intrinsicContentSize() -> CGSize {
        let size = super.intrinsicContentSize()
        return CGSizeMake(
            size.width + leftPadding + rightPadding,
            size.height + topPadding + bottomPadding
        )
    }
}