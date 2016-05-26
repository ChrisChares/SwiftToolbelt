//
//  DynamicCollectionView.swift
//  Playerbook
//
//  Created by Chris on 4/26/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

import UIKit

class DynamicCollectionView : UICollectionView {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if CGSizeEqualToSize(bounds.size, intrinsicContentSize()) == false {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        return contentSize
    }
}