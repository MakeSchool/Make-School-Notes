This is the final project of the Make School Notes Swift Tutorial. This brief documentation gives an overview of the source code involved in building this project.

#Classes and Frameworks provided as part of template project

##ConvenienceKit

Provides different components used throughout the App. The biggest component used by this app is the `TextView` that unlike `UITextView` allows to display a placeholder text.

##Realm

A simple persistence framework. Used to persist notes created in the app.

#Class Overview

##StyleConstants

Defines the default blue color as a constant to avoid duplicating that information throughout the app.

##NotesTableViewCell

Displays a a note, including title and creation date.

##NotesViewController

Main View Controller of the app. Lists all notes created by a user. Allows user to filter notes by searching. Also allows users to delete notes.

##NewNoteViewController

A container View Controller that provides a top bar allowing users to save a new note, or cancel the process. This ViewController contains a `NoteDisplayViewController` that provides text field and text view to edit the newly created note.

##NoteDisplayViewController

Displays a note and allows a user to edit it. Contains text field for title and text view for note body. Also contains a bottom bar that provides a deleted button.


