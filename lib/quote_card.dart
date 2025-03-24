import 'package:flutter/material.dart';
import 'package:myapp/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback delete, edit;
  QuoteCard({required this.quote, required this.delete, required this.edit });

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
            Row(
              children: [
                TextButton(
                  onPressed: delete, 
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: edit, 
                  child: Text(
                    "Edit",
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                  ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
