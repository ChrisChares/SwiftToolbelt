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
public class DynamicCollectionView : UICollectionView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if CGSizeEqualToSize(bounds.size, intrinsicContentSize()) == false {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override func intrinsicContentSize() -> CGSize {
        return contentSize
    }
}