import 'package:veep_meep/features/domain/entities/veep_entity.dart';

class MatchEntity {
  final int likes;
  final int picks;
  final List<VeepEntity> veepEntity;

  MatchEntity({
    required this.likes,
    required this.picks,
    required this.veepEntity,
  });
}
