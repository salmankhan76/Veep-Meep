import 'dart:typed_data';

class UserImageChangeRequest {
  final int userId;
  final String extension;
  final int updateBy;
  final Uint8List profile;

  UserImageChangeRequest(
      {required this.userId,
        required this.extension,
        required this.updateBy,
        required this.profile});
}
