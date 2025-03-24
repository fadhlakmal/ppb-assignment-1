import 'dart:io';

class Quote {
  String text;
  String author;
  File? selectedImage;

  Quote({required this.text, required this.author, this.selectedImage});
}
