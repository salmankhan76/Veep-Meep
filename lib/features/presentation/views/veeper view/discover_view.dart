import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_event.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_state.dart';
import 'package:veep_meep/features/presentation/views/veeper%20view/discover_classic_view.dart';
import 'package:veep_meep/features/presentation/views/veeper%20view/discover_gallery_view.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../domain/entities/veep_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class DiscoverView extends BaseView {
  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends BaseViewState<DiscoverView> {
  var bloc = injection<VeepBloc>();
  bool _isClassic = false;
  List<VeepEntity> veepData = [];

  @override
  void initState() {
    bloc.add(GetVeepDataEvent(userId: 0));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: BlocProvider<VeepBloc>(
        create: (_) => bloc,
        child: BlocListener<VeepBloc, BaseState<VeepState>>(
            listener: (_, state) {
              if (state is VeepDataSuccessState) {
                setState(() {
                  veepData.clear();
                  if (AppConstants.kIsBizAccount) {
                    veepData.addAll(
                      state.output
                          .where((element) => element.accountType == 2)
                          .map(
                            (e) => VeepEntity(
                                veepId: e.veepId ?? 0,
                                name: e.name ?? '',
                                distance: e.distance ?? 0,
                                veepStatus: e.veepStatus,
                                age: e.age,
                                bio: e.bio,
                                designation: e.designation,
                                fb: e.fb,
                                serviceName: e.serviceName,
                                city: e.city,
                                country: e.country,
                                slogan: e.slogan,
                                web: e.web,
                                gender: e.gender,
                                hobbies: e.hobbies,
                                profileImage: e.profileImage,
                                images: e.images,
                                instagram: e.instagram,
                                linkedin: e.linkedin,
                                snapchat: e.snapchat,
                                twitter: e.twitter,
                                accountType: e.accountType),
                          ),
                    );
                  } else {
                    veepData.addAll(
                      state.output
                          .where((element) => element.accountType == 1)
                          .map(
                            (e) => VeepEntity(
                              veepId: e.veepId ?? 0,
                              name: e.name ?? '',
                              distance: e.distance ?? 0,
                              veepStatus: e.veepStatus,
                              age: e.age,
                              bio: e.bio,
                              profileImage: e.profileImage,
                              designation: e.designation,
                              fb: e.fb,
                              gender: e.gender,
                              hobbies: e.hobbies,
                              images: e.images,
                              instagram: e.instagram,
                              linkedin: e.linkedin,
                              snapchat: e.snapchat,
                              twitter: e.twitter,
                              accountType: e.accountType,
                            ),
                          ),
                    );
                  }
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _isClassic == true
                      ? DiscoverClassicView(
                          onRefresh: () {
                            setState(() {
                              _isClassic = !_isClassic;
                            });
                          },
                          veepList: veepData,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: DiscoverGalleryView(
                            onRefresh: () {
                              setState(() {
                                _isClassic = !_isClassic;
                              });
                            },
                            veepList: veepData,
                          ),
                        ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
