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
  
  enum State {
    case DefaultMode
    case SearchMode
  }
  
  var notes: RLMResults! {
    didSet {
      if let tableView = tableView {
        tableView.reloadData()
      }
    }
  }
  
  var selectedNote: Note?
  
  var state: State = .DefaultMode {
    didSet {
      switch (state) {
      case .DefaultMode:
        notes = Note.allObjects()
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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    state = .DefaultMode
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)

    state = .DefaultMode
    
    if (self.navigationController!.navigationBarHidden) {
      self.navigationController!.setNavigationBarHidden(false, animated: animated)
    }
  }

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowExistingNote") {
      let noteViewController = segue.destinationViewController as! NoteDisplayViewController
      noteViewController.note = selectedNote
    }
  }
  
  //MARK: - Search
  func searchNotes(searchString: String) -> RLMResults {
    let searchPredicate = NSPredicate(format: "title CONTAINS[c] %@ OR content CONTAINS[c] %@", searchString, searchString)
    return Note.objectsWithPredicate(searchPredicate)
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