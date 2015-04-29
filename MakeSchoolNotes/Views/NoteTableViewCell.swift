//
//  NoteTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

  // initialize the date formatter only once, using a static computed property
  static var dateFormatter: NSDateFormatter = {
    var formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!

  var note: Note? {
    didSet {
      if let note = note, titleLabel = titleLabel, dateLabel = dateLabel {
        self.titleLabel.text = note.title
        self.dateLabel.text = NoteTableViewCell.dateFormatter.stringFromDate(note.modificationDate)
      }
    }
  }
  
}
