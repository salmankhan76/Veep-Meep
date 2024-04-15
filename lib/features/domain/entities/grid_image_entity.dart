// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class GridImageEntity {
  int orderId;
  Uint8List? gridImage;
  String? extension;
  String? networkImage;

  GridImageEntity({
    required this.orderId,
    this.gridImage,
    this.extension,
    this.networkImage
  });
}
