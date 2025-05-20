import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'item.dart';

class ItemModel extends ChangeNotifier {
  final List<Item> _item = [];
  List<Item> get items => _item;

  void addItem(Item item) {
    _item.add(item);
    notifyListeners();
  }

  ImagePicker imagePicker = ImagePicker();

  List<File>? selectedImage = [];

  Future<void> imageSelector() async {
    List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null) {
      //selectedImage = File(image.path);
      selectedImage!.addAll(
        images.map((toElement) => File(toElement.path)).toList(),
      );
    }
    notifyListeners();
  }

  void removeImage(index) {
    selectedImage!.removeAt(index);
    notifyListeners();
  }
  Item ? _selectedItem ;
  Item ? get selectedItem => _selectedItem;
  selectItem(Item item){
    _selectedItem=item;
    notifyListeners();

  }

}
