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
  
  var notes:RLMResults!

  @IBOutlet weak var tableView: UITableView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    notes = Note.allObjects()
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  
    var textView = UITextView()
  }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as UITableViewCell
    let row = UInt(indexPath.row)
    let note = notes.objectAtIndex(row) as Note
    cell.textLabel!.text = note.title

    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Int(notes?.count ?? 0)
  }
  
}

extension ViewController: UITableViewDelegate {
  
}

