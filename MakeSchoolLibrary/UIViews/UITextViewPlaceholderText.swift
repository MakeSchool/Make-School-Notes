//
//  UITextViewPlaceholderText.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class MKSTextView : UITextView {

  var placeholderText: String = "Tap to edit"
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "textViewDidBeginEditing:",
      name: UITextViewTextDidBeginEditingNotification,
      object: self)
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "textViewDidEndEditing:",
      name: UITextViewTextDidEndEditingNotification,
      object: self)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override var text: String! {
    didSet {
      if let text = text where text == "" {
        if (showsPlaceholderText == nil) {
          showsPlaceholderText = true
        }
      }
    }
  }
  
  var textValue:String {
    get {
      if let showsPlaceholderText = showsPlaceholderText
        where showsPlaceholderText == true {
          return ""
      } else {
        return text
      }
    }
  }
  
  private (set) var showsPlaceholderText: Bool? {
    didSet {
      if let showsPlaceholderText = showsPlaceholderText {
        if (showsPlaceholderText == true) {
          textColor = UIColor.lightGrayColor()
          text = placeholderText
        } else {
          textColor = UIColor.blackColor()
        }
      }
    }
  }
  
  func textViewDidEndEditing(notification: NSNotification) {
    self.showsPlaceholderText = (count(self.text) == 0)
  }
  
  func textViewDidBeginEditing(notification: NSNotification) {
    if let showsPlaceholderText = showsPlaceholderText
      where showsPlaceholderText == true {
        self.showsPlaceholderText = false
        text = ""
    }
  }
  
}
