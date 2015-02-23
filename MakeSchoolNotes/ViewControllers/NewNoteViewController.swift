//
//  NewNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Realm

class NewNoteViewController: UIViewController {

  var currentNote: Note?
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowNote") {
      currentNote = Note()
      let noteViewController = segue.destinationViewController as! NoteDisplayViewController
      noteViewController.note = currentNote
      noteViewController.editMode = false
    }
  }
  
  @IBAction func saveButtonTapped(sender: AnyObject) {
    let realm = RLMRealm.defaultRealm()
    realm.transactionWithBlock() {
      realm.addObject(self.currentNote)
      self .dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
}