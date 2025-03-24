import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children:
            quotes
                .map(
                  (quote) => QuoteCard(
                    quote: quote,
                    delete: () {
                      setState(() {
                        quotes.remove(quote);
                      });
                    },
                    duplicate: () {
                      setState(() {
                        quotes.insert(quotes.indexOf(quote), quote);
                      });
                    },
                  ),
                )
                .toList(),
      ),
    );
  }
}
