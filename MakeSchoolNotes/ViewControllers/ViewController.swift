//
//  ViewController.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Realm


class ViewController: UIViewController {
  
  var notes: RLMResults!
  var selectedNote: Note?

  @IBOutlet weak var tableView: UITableView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    notes = Note.allObjects()
    tableView.reloadData()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    if (self.navigationController!.navigationBarHidden) {
      self.navigationController!.setNavigationBarHidden(false, animated: animated)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController!.hidesBarsWhenKeyboardAppears = true
    tableView.dataSource = self
    tableView.delegate = self
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowExistingNote") {
      let noteViewController = segue.destinationViewController as! NoteDisplayViewController
      noteViewController.note = selectedNote
    }
  }
  
}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as! NoteTableViewCell
    let row = UInt(indexPath.row)
    let note = notes.objectAtIndex(row) as! Note
    cell.note = note
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Int(notes?.count ?? 0)
  }
  
}

extension ViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedNote = notes.objectAtIndex(UInt(indexPath.row)) as? Note
    self.performSegueWithIdentifier("ShowExistingNote", sender: self)
  }
  
}

extension ViewController: UISearchBarDelegate {
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    self.navigationController!.setNavigationBarHidden(false, animated: true)
  }
  
}