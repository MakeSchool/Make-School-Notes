//
//  LoadIndicator.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import UIKit

public func show() {
  let window = UIApplication.sharedApplication().keyWindow
  
  if let window = window {
    var view = window.rootViewController!.view
    
    //only apply the blur if the user hasn't disabled transparency effects
    if !UIAccessibilityIsReduceTransparencyEnabled() {
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = view.bounds //view is self.view in a UIViewController
      view.addSubview(blurEffectView)
      //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view
      
      //add auto layout constraints so that the blur fills the screen upon rotating device
      blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
      view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
      view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
      view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
      view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    } else {
      view.backgroundColor = UIColor.blackColor()
    }
  }
}