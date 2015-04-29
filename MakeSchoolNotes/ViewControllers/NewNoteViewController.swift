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
  
  /* 
    This segue is performed as soon as NewNoteViewController appears.
    NewNoteViewController has a container view that contains the NoteDisplayViewController
  */
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowNewNote") {
      // create a new Note and hold onto it, to be able to save it later
      currentNote = Note()
      let noteViewController = segue.destinationViewController as! NoteDisplayViewController
      noteViewController.note = currentNote
      noteViewController.editMode = false
    }
  }
  
  @IBAction func saveButtonTapped(sender: AnyObject) {
    // if the save button is tapped, store the new note
    let realm = RLMRealm.defaultRealm()
    realm.transactionWithBlock() {
      realm.addObject(self.currentNote)
      self .dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
}