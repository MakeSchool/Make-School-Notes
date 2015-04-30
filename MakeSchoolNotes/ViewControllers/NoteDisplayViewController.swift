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
import ConvenienceKit

class NoteDisplayViewController: UIViewController {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var contentTextView: TextView!
  @IBOutlet weak var deleteButton: UIBarButtonItem!
  @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
  
  var keyboardNotificationHandler: KeyboardNotificationHandler?
  
  var note: Note? {
    didSet {
      displayNote(self.note)
    }
  }
  
  var editMode: Bool
  
  //MARK: Initialization
  
  required init(coder aDecoder: NSCoder) {
    editMode = true

    super.init(coder: aDecoder)
  }
  
  //MARK: View Lifecycle
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    displayNote(self.note)
    applyEditMode(self.editMode)
    titleTextField.returnKeyType = .Next;
    
    keyboardNotificationHandler = KeyboardNotificationHandler()
    
    keyboardNotificationHandler!.keyboardWillBeHiddenHandler = { (height: CGFloat) in
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.toolbarBottomSpace.constant = 0
        self.view.layoutIfNeeded()
      })
    }
    
    keyboardNotificationHandler!.keyboardWillBeShownHandler = { (height: CGFloat) in
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.toolbarBottomSpace.constant = height
        self.view.layoutIfNeeded()
      })
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    keyboardNotificationHandler = nil
    
    saveNote()
  }
  
  //MARK: Business Logic
  
  func displayNote(note: Note?) {
    if let note = note,
      titleTextField = titleTextField,
      contentTextView = contentTextView  {
        titleTextField.text = note.title
        contentTextView.text = note.content
    }
  }
  
  func applyEditMode(editMode: Bool) {
    if (!editMode) {
      titleTextField.becomeFirstResponder()
    }
    
    if let deleteButton = self.deleteButton {
      self.deleteButton.enabled = editMode
    }
  }
  
  func saveNote() {
    if let note = self.note {
      let realm = RLMRealm.defaultRealm()

      realm.transactionWithBlock { () -> Void in
        if (note.title != self.titleTextField.text || note.content != self.contentTextView.textValue) {
          note.title = self.titleTextField.text
          note.content = self.contentTextView.textValue
          note.modificationDate = NSDate()
        }
      }
    }
  }
  
  //MARK: Button Callbacks
  
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

extension NoteDisplayViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if (textField == titleTextField) {
      contentTextView.becomeFirstResponder()
    }
    
    return false
  }
  
}
