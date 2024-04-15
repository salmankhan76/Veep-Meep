import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_event.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_state.dart';

import '../../../../error/messages.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/common/common_error_response.dart';
import '../../../domain/repositories/repository.dart';
import '../base_bloc.dart';
import '../base_state.dart';

class ChatBloc extends Base<ChatEvent, BaseState<ChatState>> {
  final AppSharedData appSharedData;
  final Repository repository;

  ChatBloc({required this.appSharedData, required this.repository})
      : super(InitialChatState()) {
    on<GetVeepedUsersEvent>(_veepedUsersAPI);
    on<SendMessageEvent>(_sendMessageAPI);
    on<GetMessagesEvent>(_getMessagesAPI);
  }

  _veepedUsersAPI(
      GetVeepedUsersEvent event, Emitter<BaseState<ChatState>> emit) async {
    emit(APILoadingState());

    final result = await repository.getAllVeepedChatUserAPI();
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return VeepedUsersSuccessState(message: r.message, output: r.output!);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseCode: '', responseError: r.message));
        }
      }),
    );
  }

  _sendMessageAPI(
      SendMessageEvent event, Emitter<BaseState<ChatState>> emit) async {
    final result = await repository.sendMessageAPI(event.sendMsgRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return SendMsgSuccessState(message: r.message, sendMsgData: r.output);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _getMessagesAPI(
      GetMessagesEvent event, Emitter<BaseState<ChatState>> emit) async {
    final result = await repository.getAllMessagesAPI(event.receiver_id);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return GetAllMessagesSuccessState(
              message: r.message, output: r.output!);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }
}
