import '../../data/models/common/common_error_response.dart';

abstract class BaseState<K> {
  const BaseState();
}

class BaseInitial extends BaseState {}

class APIFailureState<K> extends BaseState<K> {
  final ErrorResponseModel errorResponseModel;

  APIFailureState({required this.errorResponseModel});
}

class APILoadingState<K> extends BaseState<K> {
  final bool shouldShowDialog;

  APILoadingState({this.shouldShowDialog = false});
}
