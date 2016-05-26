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
struct QuickAlert {
    
    let alert : UIAlertController
    
    init(msg: String, title: String? = nil) {
        alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
    }
    /**
        Present the wrapped UIAlertController
     
        - Parameter vc: The UIViewController to present the UIAlertController from.  It is optional so you can use this from within closures with a weak self seamlessly
    */
    func show(vc: UIViewController?) -> Void {
        vc?.presentViewController(alert, animated: true, completion: nil)
    }
}
//
//import JGProgressHUD
//
//extension UIView {
//    func showSuccess(delay: Float = 1.5) {
//        let hud = JGProgressHUD(style: .Dark)
//        hud.textLabel.text = "Success!"
//        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//        hud.square = true
//        
//        hud.showInView(self, animated: true)
//        hud.dismissAfterDelay(1.5)
//    }
//    
//    func showError(text: String = "", delay: Float = 3.0) {
//        let hud = JGProgressHUD(style: .Dark)
//        hud.textLabel.text = text
//        hud.indicatorView = JGProgressHUDErrorIndicatorView()
////        hud.square = true
//        
//        hud.showInView(self, animated: true)
//        hud.dismissAfterDelay(3.0, animated: true)
//    }
//    
//    func showProgress(text: String = "Loading") {
//        let hud = JGProgressHUD(style: .Dark)
//        hud.textLabel.text = text
//        hud.showInView(self, animated: true)
//    }
//    
//    func hideProgress() {
//        if let hud = subviews.find({ $0 is JGProgressHUD }) as? JGProgressHUD {
//            hud.dismiss()
//        }
//    }
//}