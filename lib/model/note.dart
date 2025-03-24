import 'dart:io';

class Note {
  String title;
  String description;
  File? selectedImage;

  Note({required this.title, required this.description, this.selectedImage});
}
