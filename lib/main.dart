import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/quote.dart';
import 'package:myapp/quote_card.dart';

void main() => runApp(MaterialApp(home: QuoteLists()));

class QuoteLists extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteLists> {
  List<Quote> quotes = [
    Quote(
      author: 'Oscar Wilde',
      text: 'Be yourself; everyone else is already taken',
    ),
    Quote(
      author: 'Oscar Wilde',
      text: 'I have nothing to declare except my genius',
    ),
    Quote(
      author: 'Oscar Wilde',
      text: 'The truth is rarely pure and never simple',
    ),
  ];

  Future<File?> pickGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return null;
    return File(image.path);
  }

  void addQuote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newText = '';
        String newAuthor = '';
        File? newImage;

        return AlertDialog(
          title: Text('Add Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter text'),
                onChanged: (value) {
                  newText = value;
                },
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: 'Enter quote'),
                onChanged: (value) {
                  newAuthor = value;
                },
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  newImage = await pickGalleryImage();
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
                if (newText.isNotEmpty && newAuthor.isNotEmpty) {
                  setState(() {
                    quotes.add(
                      Quote(
                        text: newText,
                        author: newAuthor,
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

  void editQuote(Quote quote) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newText = quote.text;
        String newAuthor = quote.author;
        File? newImage;

        return AlertDialog(
          title: Text('Edit Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Edit text'),
                controller: TextEditingController(text: quote.text),
                onChanged: (value) {
                  newText = value;
                },
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: 'Edit author'),
                controller: TextEditingController(text: quote.author),
                onChanged: (value) {
                  newAuthor = value;
                },
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  newImage = await pickGalleryImage();
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
                if (newText.isNotEmpty && newAuthor.isNotEmpty) {
                  setState(() {
                    quote.text = newText;
                    quote.author = newAuthor;
                    quote.selectedImage = newImage;
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

  void deleteQuote(Quote quote) {
    setState(() {
      quotes.remove(quote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
              quotes
                  .asMap()
                  .entries
                  .map(
                    (entry) => QuoteCard(
                      quote: entry.value,
                      delete: () => deleteQuote(entry.value),
                      edit: () => editQuote(entry.value),
                    ),
                  )
                  .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addQuote,
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
