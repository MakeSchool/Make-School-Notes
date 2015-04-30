//
//  ViewController.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Realm

class NotesViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  // In Default Mode all Notes are displayed, in search mode only a filtered subset
  enum State {
    case DefaultMode
    case SearchMode
  }
  
  var notes: RLMResults! {
    didSet {
      // Whenever notes update, update the table view
      if let tableView = tableView {
        tableView.reloadData()
      }
    }
  }
  
  // temporarily stores the note that a user selected by tapping a cell
  var selectedNote: Note?
  
  // .DefaultMode is the initial state
  var state: State = .DefaultMode {
    didSet {
      // update notes and search bar whenever State changes
      switch (state) {
      case .DefaultMode:
        notes = Note.allObjects().sortedResultsUsingProperty("modificationDate", ascending: false)
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.showsCancelButton = false
      case .SearchMode:
        let searchText = searchBar?.text ?? ""
        searchBar.setShowsCancelButton(true, animated: true)
        notes = searchNotes(searchText)
        self.navigationController!.setNavigationBarHidden(true, animated: true)
      }
    }
  }
  
  //MARK: View Lifecycle
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // set the background color of this view, to cover the free space under the status bar, when the navigaiton bar disappears
    self.view.backgroundColor = StyleConstants.defaultBlueColor
    
    state = .DefaultMode
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)

    state = .DefaultMode
    
    if (self.navigationController!.navigationBarHidden) {
      self.navigationController!.setNavigationBarHidden(false, animated: animated)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }
  
  //MARK: Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowExistingNote") {
      let noteViewController = segue.destinationViewController as! NoteDisplayViewController
      noteViewController.note = selectedNote
    }
  }
  
  //MARK: Search
  
  func searchNotes(searchString: String) -> RLMResults {
    let searchPredicate = NSPredicate(format: "title CONTAINS[c] %@ OR content CONTAINS[c] %@", searchString, searchString)
    return Note.objectsWithPredicate(searchPredicate)
  }
}

extension NotesViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as! NoteTableViewCell
    let row = UInt(indexPath.row)
    let note = notes[row] as! Note
    cell.note = note
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Int(notes?.count ?? 0)
  }
  
}

extension NotesViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedNote = notes.objectAtIndex(UInt(indexPath.row)) as? Note
    self.performSegueWithIdentifier("ShowExistingNote", sender: self)
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if (editingStyle == .Delete) {
      let note = notes[UInt(indexPath.row)] as! RLMObject
      let realm = RLMRealm.defaultRealm()
     
      realm.transactionWithBlock() {
        realm.deleteObject(note)
      }
      
      notes = Note.allObjects().sortedResultsUsingProperty("modificationDate", ascending: false)
    }
  }
  
}

extension NotesViewController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    state = .SearchMode
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    state = .DefaultMode
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    notes = searchNotes(searchText)
  }
  
}