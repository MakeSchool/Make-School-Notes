//
//  KeyboardNotificationHandler.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

@objc(KeyboardNotificationHandler)
class KeyboardNotificationHandler {
  
  typealias KeyboardHandlerCallback = (CGFloat) -> ()
  
  var keyboardWillBeHiddenHandler: KeyboardHandlerCallback?
  var keyboardWillBeShownHandler:  KeyboardHandlerCallback?
  
  required init() {
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "keyboardWillBeShown:",
      name: "UIKeyboardWillShowNotification",
      object: nil
    )
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "keyboardWillBeHidden:",
      name: "UIKeyboardWillHideNotification",
      object: nil
    )
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func keyboardWillBeShown(notification: NSNotification) {
    invokeHandler(notification, callback: keyboardWillBeShownHandler)
  }
  
  func keyboardWillBeHidden(notification: NSNotification) {
    invokeHandler(notification, callback: keyboardWillBeHiddenHandler)
  }
  
  private func invokeHandler(notification: NSNotification, callback: KeyboardHandlerCallback?) {
    if let info = notification.userInfo {
      var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
      if let callback = callback {
        callback(keyboardFrame.height)
      }
    }
  }
  
}