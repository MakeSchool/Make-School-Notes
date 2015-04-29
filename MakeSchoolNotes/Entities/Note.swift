//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Realm

class Note : RLMObject {
  
  dynamic var title: String = ""
  dynamic var content: String = ""
  dynamic var modificationDate = NSDate()
  
}