import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_event.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_state.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/views/base_view.dart';
import 'package:veep_meep/features/presentation/views/home/widget/favorite_card_ui.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/veep_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';

class FavoriteView extends BaseView {
  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends BaseViewState<FavoriteView> {
  var bloc = injection<VeepBloc>();
  List<VeepEntity> likedList = [];
  int _currentSelection = 0;
  final Map<int, Widget> _children = {
    0: Text(
      '  4 Likes  ',
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize:AppDimensions.kFontSize14),
    ),
    1: Text(
      '  3 Top Picks  ',
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize:AppDimensions.kFontSize14),
    ),
  };

  @override
  void initState() {
    bloc.add(GetFavouriteDataEvent(userId: 1));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<VeepBloc>(
        create: (_) => bloc,
        child: BlocListener<VeepBloc, BaseState<VeepState>>(
          listener: (_, state) {
            if (state is FavouriteDataSuccessState) {
              setState(() {
                likedList.clear();
                likedList.addAll(state.likedList);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: double.infinity,
                      child: MaterialSegmentedControl<int>(
                        children: _children,
                        selectionIndex: _currentSelection,
                        borderColor: AppColors.colorGray400,
                        selectedColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        unselectedColor: AppColors.fontColorWhite,
                        borderRadius: 32.0,
                        verticalOffset: 10,
                        horizontalPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        onSegmentChosen: (index) {
                          setState(() {
                            _currentSelection = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          padding: const EdgeInsets.all(15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (.7 / 1),
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          shrinkWrap: true,
                          itemCount: _currentSelection == 0
                              ? likedList.length
                              : likedList.where((element) => element.isPicked == true).length,
                          itemBuilder: (BuildContext context, int index) {
                            return FavoriteCardUI(
                              veepEntity: _currentSelection == 0
                                  ? likedList[index]
                                  : likedList.where((element) => element.isPicked == true).toList()[index],
                              isLiked: _currentSelection == 0, onTap: () {
                              Navigator.pushNamed(context, Routes.kDiscoverProfileView,
                                  arguments: likedList[index]);
                            },
                            );
                          },
                        ),
                      ),
                    ),
                    _currentSelection == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: AppButton(
                                buttonText: 'See Who Likes You',
                                buttonColor: AppConstants.kIsBizAccount
                                    ? AppColors.colorGreen
                                    : AppColors.colorBlue,
                                onTapButton: () {}),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
