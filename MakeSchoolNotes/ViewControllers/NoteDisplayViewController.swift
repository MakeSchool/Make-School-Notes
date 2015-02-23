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
  @IBOutlet weak var deleteButton: UIBarButtonItem!
  @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
  
  var keyboardNotificationHandler: KeyboardNotificationHandler
  
  var note: Note? {
    didSet {
      displayNote(self.note)
    }
  }
  
  var editMode: Bool {
    didSet{
      applyEditMode(editMode)
    }
  }
  
  
  required init(coder aDecoder: NSCoder) {
    editMode = true
    keyboardNotificationHandler = KeyboardNotificationHandler()

    super.init(coder: aDecoder)
    
    keyboardNotificationHandler.keyboardWillBeHiddenHandler = { (height: CGFloat) in
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.toolbarBottomSpace.constant = 0
        self.view.layoutIfNeeded()
      })
    }
    
    keyboardNotificationHandler.keyboardWillBeShownHandler = { (height: CGFloat) in
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.toolbarBottomSpace.constant = height
        self.view.layoutIfNeeded()
      })
    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    displayNote(self.note)
    applyEditMode(self.editMode)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    saveNote()
  }
  
  func displayNote(note: Note?) {
    if let note = note,
      titleTextField = titleTextField,
      contentTextView = contentTextView  {
        titleTextField.text = note.title
        contentTextView.text = note.content
    }
  }
  
  func applyEditMode(editMode: Bool) {
    if let deleteButton = self.deleteButton {
      self.deleteButton.enabled = editMode
    }
  }
  
  func saveNote() {
    if let note = self.note {
      let realm = RLMRealm.defaultRealm()

      realm.transactionWithBlock { () -> Void in
        note.title = self.titleTextField.text
        note.content = self.contentTextView.text
        note.modificationDate = NSDate()
      }
    }
  }
  
  @IBAction func deleteButtonTapped(sender: AnyObject) {
    let realm = RLMRealm.defaultRealm()
    realm.transactionWithBlock { () -> Void in
      realm.deleteObject(self.note)
    }
    
    self.note = nil
    
    if let presentingViewController = self.presentingViewController {
      presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    } else if let navigationController = self.navigationController {
      navigationController.popViewControllerAnimated(true)
    }
  }
  
}