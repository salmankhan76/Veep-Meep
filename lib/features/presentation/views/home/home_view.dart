import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_state.dart';
import 'package:veep_meep/features/presentation/views/chat/all_chat_view.dart';
import 'package:veep_meep/features/presentation/views/home/favorite_view.dart';
import 'package:veep_meep/features/presentation/views/matches/all_matches_view.dart';
import 'package:veep_meep/features/presentation/views/profile/profile_outer_view.dart';
import 'package:veep_meep/features/presentation/views/veeper%20view/discover_view.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/enums.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/veep/veep_bloc.dart';
import '../../bloc/veep/veep_event.dart';
import '../base_view.dart';

class HomeView extends BaseView {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseViewState<HomeView> {
  var bloc = injection<VeepBloc>();
  var _selectedMenuItem = HomeUiType.DISCOVER;
  int _selectedIndex = 1;

  @override
  void initState() {
    bloc.add(GetVeepDataEvent(userId: appSharedData.getUserId()!));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMenuItem == HomeUiType.PROFILE
          ? Colors.white
          : _selectedMenuItem == HomeUiType.DISCOVER ||
                  _selectedMenuItem == HomeUiType.PROFILE
              ? (_selectedMenuItem == HomeUiType.PROFILE &&
                      AppConstants.kIsBizAccount)
                  ? AppColors.fontColorWhite
                  : AppColors.colorPrimary
              : AppColors.colorGray50,
      body: BlocProvider<VeepBloc>(
        create: (_) => bloc,
        child: BlocListener<VeepBloc, BaseState<VeepState>>(
            listener: (_, state) {
              if (state is VeepDataSuccessState) {
                setState(() {
                  AppConstants.profileData = state.output.first;
                  if (AppConstants.profileData!.images!.isNotEmpty &&
                      AppConstants.profileData!.profileImage!.isEmpty) {
                    AppConstants.profileData!.images!.forEach((element) {
                      if (element != null && element.isNotEmpty) {
                        AppConstants.profileData!.profileImage = element;
                      }
                    });
                  }
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: _getBody()),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: AppColors.colorGray50,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkResponse(
                  child: SvgPicture.asset(AppImages.icLocation,
                      color: _selectedIndex == 1
                          ? AppColors.colorBlue
                          : Colors.black),
                  onTap: () {
                    onTabTapped(1);
                    setState(() {
                      _selectedMenuItem = HomeUiType.DISCOVER;
                    });
                  }),
              InkResponse(
                  child: SvgPicture.asset(AppImages.icFavourite,
                      color: _selectedIndex == 2
                          ? AppColors.colorBlue
                          : Colors.black),
                  onTap: () {
                    onTabTapped(2);
                    setState(() {
                      _selectedMenuItem = HomeUiType.FAVOURITE;
                    });
                  }),
              InkResponse(
                  child: SvgPicture.asset(AppImages.icStar,
                      color: _selectedIndex == 3
                          ? AppColors.colorBlue
                          : Colors.black),
                  onTap: () {
                    onTabTapped(3);
                    setState(() {
                      _selectedMenuItem = HomeUiType.MATCH;
                    });
                  }),
              InkResponse(
                  child: SvgPicture.asset(AppImages.icMessage,
                      color: _selectedIndex == 4
                          ? AppColors.colorBlue
                          : Colors.black),
                  onTap: () {
                    onTabTapped(4);
                    setState(() {
                      _selectedMenuItem = HomeUiType.CHAT;
                    });
                  }),
              InkResponse(
                  child: SvgPicture.asset(AppImages.icProfile,
                      color: _selectedIndex == 5
                          ? AppColors.colorBlue
                          : Colors.black),
                  onTap: () {
                    onTabTapped(5);
                    setState(() {
                      _selectedMenuItem = HomeUiType.PROFILE;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;

      ///call your PageController.jumpToPage(index) here too, if needed
    });
  }

  _getBody() {
    switch (_selectedMenuItem) {
      case HomeUiType.DISCOVER:
        return DiscoverView();
      case HomeUiType.FAVOURITE:
        return FavoriteView();
      case HomeUiType.MATCH:
        return AllMatchesView(
          onSendMessage: () {
            setState(() {
              _selectedMenuItem = HomeUiType.CHAT;
              _selectedIndex = 4;
            });
          },
        );
      case HomeUiType.CHAT:
        return AllChatView();
      case HomeUiType.PROFILE:
        return ProfileOuterView();
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
