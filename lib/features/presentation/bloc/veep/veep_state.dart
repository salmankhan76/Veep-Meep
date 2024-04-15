import '../../../data/models/responses/veep_data_response.dart';
import '../../../domain/entities/veep_entity.dart';
import '../base_state.dart';

abstract class VeepState extends BaseState<VeepState> {}

class InitialVeepState extends VeepState {}

class VeepDataSuccessState extends VeepState {
  final String message;
  final List<VeepData> output;

  VeepDataSuccessState({required this.message, required this.output});
}

class MatchDataSuccessState extends VeepState {
  final String message;
  final List<VeepData> output;

  MatchDataSuccessState({required this.message, required this.output});
}

class FavouriteDataSuccessState extends VeepState {
  final List<VeepEntity> likedList;


  FavouriteDataSuccessState({required this.likedList});
}