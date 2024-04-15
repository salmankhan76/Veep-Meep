import '../base_event.dart';

abstract class VeepEvent extends BaseEvent {}

class GetVeepDataEvent extends VeepEvent {
  final int userId;

  GetVeepDataEvent({required this.userId});
}

class GetMatchDataEvent extends VeepEvent {
  final int userId;

  GetMatchDataEvent({required this.userId});
}

class GetFavouriteDataEvent extends VeepEvent {
  final int userId;

  GetFavouriteDataEvent({required this.userId});
}