import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/models/note.dart';
import 'package:myapp/services/image_service.dart';
import 'package:myapp/widgets/note_card.dart';
import 'package:myapp/data/notes.dart';

class NoteListsScreen extends StatefulWidget {
  const NoteListsScreen({super.key});

  @override
  _NoteListScreentate createState() => _NoteListScreentate();
}

class _NoteListScreentate extends State<NoteListsScreen> {
  final ImageService _imageService = ImageService();

  void addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = '';
        String newDesc = '';
        File? newImage;

        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter title'),
                onChanged: (value) {
                  newTitle = value;
                },
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: 'Enter description'),
                onChanged: (value) {
                  newDesc = value;
                },
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  newImage = await _imageService.pickGalleryImage();
                  setState(() {});
                },
                child: Text('Pick Image'),
              ),
              if (newImage != null)
                Image.file(
                  newImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTitle.isNotEmpty && newDesc.isNotEmpty) {
                  setState(() {
                    notes.add(
                      Note(
                        title: newTitle,
                        description: newDesc,
                        selectedImage: newImage,
                      ),
                    );
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void editNote(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = note.title;
        String newDesc = note.description;
        File? newImage = note.selectedImage;

        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Edit title'),
                controller: TextEditingController(text: note.title),
                onChanged: (value) {
                  newTitle = value;
                },
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: 'Edit description'),
                controller: TextEditingController(text: note.description),
                onChanged: (value) {
                  newDesc = value;
                },
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  newImage = await _imageService.pickGalleryImage();
                  setState(() {});
                },
                child: Text('Pick Image'),
              ),
              if (newImage != null)
                Image.file(
                  newImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTitle.isNotEmpty && newDesc.isNotEmpty) {
                  setState(() {
                    note.title = newTitle;
                    note.description = newDesc;
                    note.selectedImage = newImage;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteNote(Note note) {
    setState(() {
      notes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body:
          notes.isEmpty
              ? Center(
                child: Text(
                  'No notes, tap + to add notes.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children:
                      notes
                          .asMap()
                          .entries
                          .map(
                            (entry) => NoteCard(
                              note: entry.value,
                              delete: () => deleteNote(entry.value),
                              edit: () => editNote(entry.value),
                            ),
                          )
                          .toList(),
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
