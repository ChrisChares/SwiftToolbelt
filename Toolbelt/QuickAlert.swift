//
//  QuickAlert.swift
//  HuntFish
//
//  Created by Chris Chares on 1/20/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

/**
    A simple wrapper to quickly present messages to the user with one line of code
*/
public struct QuickAlert {
    
    public let alert : UIAlertController
    
    public init(msg: String, title: String? = nil) {
        alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }
    /**
        Present the wrapped UIAlertController
     
        - Parameter vc: The UIViewController to present the UIAlertController from.  It is optional so you can use this from within closures with a weak self seamlessly
    */
    public func show(_ vc: UIViewController?) -> Void {
        vc?.present(alert, animated: true, completion: nil)
    }
}
