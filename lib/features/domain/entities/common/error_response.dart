import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  ErrorResponse({
    required this.responseCode,
    required this.responseError,
  });

  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseError, responseCode];
}
