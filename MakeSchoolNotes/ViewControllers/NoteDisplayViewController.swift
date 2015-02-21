//
//  NoteDisplayViewController.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import UIKit
import Realm

class NoteDisplayViewController: UIViewController {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var contentTextView: UITextView!
  
  var note:Note? {
    didSet(newNote) {
      displayNote(newNote)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    saveNote()
  }
  
  func displayNote(note: Note?) {
    if let note = note {
      titleTextField.text = note.title
      contentTextView.text = note.content
    } else {
      //empty all fields
    }
  }
  
  func saveNote() {
    let realm = RLMRealm.defaultRealm()

    realm.transactionWithBlock { () -> Void in
      self.note?.title = self.titleTextField.text
      self.note?.content = self.contentTextView.text
    }
  }
  
}