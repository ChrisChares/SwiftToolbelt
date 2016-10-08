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
open class PaddedLabel : UILabel {
    
    @IBInspectable open var leftPadding: CGFloat = 0
    @IBInspectable open var topPadding: CGFloat = 0
    @IBInspectable open var rightPadding: CGFloat = 0
    @IBInspectable open var bottomPadding: CGFloat = 0

    open override var intrinsicContentSize : CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + leftPadding + rightPadding,
            height: size.height + topPadding + bottomPadding
        )
    }
}
