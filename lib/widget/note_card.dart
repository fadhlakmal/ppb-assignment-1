import 'package:flutter/material.dart';
import 'package:myapp/model/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback delete, edit;
  NoteCard({required this.note, required this.delete, required this.edit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 100.0,
              height: 100.0,
              child:
                  note.selectedImage != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          note.selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                      : Container(
                        color: Colors.grey[300],
                        child: Center(child: Text('No Image')),
                      ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    note.title,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    note.description,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey[800]),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: delete,
                        icon: Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Delete',
                      ),
                      IconButton(
                        onPressed: edit,
                        icon: Icon(Icons.edit, color: Colors.blue),
                        tooltip: 'Edit',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
