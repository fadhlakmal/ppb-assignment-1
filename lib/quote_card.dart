import 'package:flutter/material.dart';
import 'package:myapp/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback delete, duplicate;
  QuoteCard({required this.quote, required this.delete, required this.duplicate });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 6.0),
            Text(
              quote.author,
              style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: delete, 
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ),),
            SizedBox(height: 8.0,),
            TextButton(
              onPressed: duplicate, 
              child: Text(
                "Duplicate",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),)
          ],
        ),
      ),
    );
  }
}
