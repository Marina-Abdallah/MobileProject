import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'user.dart';

class UserModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();
  User? _user;

  User? get user => _user;

  void setUserName(String name) {
    if (_user != null) {
      _user!.name = name;
    } else {
      _user = User(name: name, bio: '', image: null);
    }
    notifyListeners();
  }

  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      if (_user != null) {
        _user?.image = File(image.path);
      } else {
        _user = User(
          name: "Profile",
          bio: "Code Sleep Eat, Repeat",
          image: File(image.path),
        );
      }
      notifyListeners();
    }
  }

  void removeImage() {
    _user?.image = null;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
