import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';

class PickerDataProvider extends ChangeNotifier {
  /// save selected asset items
  List<PickedAssetModel> pickedFile = [];

  void pickPath(PickedAssetModel path) {
    if (pickedFile.where((element) => element.id == path.id).isNotEmpty) {
      pickedFile.removeWhere((val) => val.id == path.id);
    } else {
      pickedFile.add(path);
    }
    notifyListeners();
  }
}
