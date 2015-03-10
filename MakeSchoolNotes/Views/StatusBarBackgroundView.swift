//
//  StatusBarBackgroundView.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class StatusBarBackgroundView: UIView {

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.backgroundColor = UIColor(red: 201/255.0, green: 201/255.0, blue: 206/255.0, alpha: 1.0)
  }

}
