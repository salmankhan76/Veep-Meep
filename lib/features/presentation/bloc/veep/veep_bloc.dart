import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/data/models/requests/favourite_data_request.dart';
import 'package:veep_meep/features/data/models/requests/veep_data_request.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_event.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_state.dart';

import '../../../../error/messages.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/common/common_error_response.dart';
import '../../../data/models/requests/match_data_request.dart';
import '../../../domain/repositories/repository.dart';
import '../base_bloc.dart';
import '../base_state.dart';

class VeepBloc extends Base<VeepEvent, BaseState<VeepState>> {
  final AppSharedData appSharedData;
  final Repository repository;

  VeepBloc({required this.appSharedData, required this.repository})
      : super(InitialVeepState()) {
    on<GetVeepDataEvent>(_veepAPI);
    on<GetMatchDataEvent>(_matchAPI);
    on<GetFavouriteDataEvent>(_favouriteAPI);
  }

  _veepAPI(GetVeepDataEvent event, Emitter<BaseState<VeepState>> emit) async {
    emit(APILoadingState());

    final result =
        await repository.veepAPI(VeepDataRequest(userId: event.userId));
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return VeepDataSuccessState(message: r.message, output: r.output!);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseCode: '', responseError: r.message));
        }
      }),
    );
  }

  _matchAPI(GetMatchDataEvent event, Emitter<BaseState<VeepState>> emit) async {
    emit(APILoadingState());

    final result =
        await repository.matchAPI(MatchDataRequest(userId: event.userId));
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return MatchDataSuccessState(message: r.message, output: r.output!);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseCode: '', responseError: r.message));
        }
      }),
    );
  }

  _favouriteAPI(
      GetFavouriteDataEvent event, Emitter<BaseState<VeepState>> emit) async {
    emit(APILoadingState());

    final result = await repository
        .favouriteAPI(FavouriteDataRequest(userId: event.userId));
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          List<VeepEntity> likedList = [];
          List<VeepEntity> pickedList = [];
          likedList.addAll(r.output!.liked!
              .map((e) => VeepEntity(
                  veepId: e.veepId!,
                  accountType: e.accountType,
                  name: e.name,
                  distance: e.distance,
                  isPicked: e.isPicked,
                  age: e.age,
                  bio: e.bio,
                  designation: e.designation,
                  fb: e.fb,
                  gender: e.gender,
                  hobbies: e.hobbies,
                  images: e.images,
                  instagram: e.instagram,
                  linkedin: e.linkedin,
                  snapchat: e.snapchat,
                  twitter: e.twitter,
                  lastActive: e.lastActivated,
                  timeExpire: e.expireTime))
              .toList());
          return FavouriteDataSuccessState(
              likedList: likedList);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseCode: '', responseError: r.message));
        }
      }),
    );
  }
}
