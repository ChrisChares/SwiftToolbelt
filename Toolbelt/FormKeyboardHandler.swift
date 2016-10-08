//
//  FormKeyboardHandler.swift
//  HuntFish
//
//  Created by Chris Chares on 3/28/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit
/*:
    NSObject subclass that auto forwards focus amongst a group of UITextField's when next/done is selected.  You can create this in IB and then connect the delegates
*/
open class FormKeyboardHandler : NSObject {
    @IBInspectable open var textFieldTopPadding: CGFloat = 14
    @IBOutlet weak open var scrollView : UIScrollView?
}

/*
    UITextFieldDelegate
*/
extension FormKeyboardHandler : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let currentTag = textField.tag
        let view = textField.superview!
        
        if let nextView = view.viewWithTag(currentTag + 1) {
            // there are more views, pass the keyboard input on to them
            nextView.becomeFirstResponder()
            return false
        } else {
            // we've reached the end captain, dismiss the keyboard
            textField.resignFirstResponder()
            // scroll back to the top if necessary
            if let scrollView = scrollView {
                scrollView.setContentOffset(CGPoint.zero, animated: true)
            }
            return true
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // make sure any UITextField that's being edited is up top
        if let scrollView = scrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - textFieldTopPadding), animated: true)
        }
    }
}
