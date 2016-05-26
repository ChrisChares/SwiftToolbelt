//
//  PaddedLabel.swift
//  Playerbook
//
//  Created by Chris Chares on 4/4/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

/*:
 UILabel subclass with optional padding that can be specified in Interface Builder
*/
@IBDesignable
public class PaddedLabel : UILabel {
    
    @IBInspectable public var leftPadding: CGFloat = 0
    @IBInspectable public var topPadding: CGFloat = 0
    @IBInspectable public var rightPadding: CGFloat = 0
    @IBInspectable public var bottomPadding: CGFloat = 0

    public override func intrinsicContentSize() -> CGSize {
        let size = super.intrinsicContentSize()
        return CGSizeMake(
            size.width + leftPadding + rightPadding,
            size.height + topPadding + bottomPadding
        )
    }
}