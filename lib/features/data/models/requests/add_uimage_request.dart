import '../../../domain/entities/grid_image_entity.dart';

class AddImageRequest {
  final int userId;
  final List<GridImageEntity> data;

  AddImageRequest({
    required this.userId,
    required this.data,
  });
}
