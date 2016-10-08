//
//  DynamicCollectionView.swift
//  Playerbook
//
//  Created by Chris on 4/26/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit
/*:
 A UICollectionView subclass that resizes to accomodate its contents
*/
open class DynamicCollectionView : UICollectionView {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.size.equalTo(intrinsicContentSize) == false {
            invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize : CGSize {
        return contentSize
    }
}
