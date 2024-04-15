import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_event.dart';
import 'package:veep_meep/features/presentation/views/base_view.dart';
import 'package:veep_meep/features/presentation/views/matches/widgets/match_card_ui.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/veep/veep_bloc.dart';
import '../../bloc/veep/veep_state.dart';

class AllMatchesView extends BaseView {
  final VoidCallback onSendMessage;

  AllMatchesView({required this.onSendMessage});

  @override
  State<AllMatchesView> createState() => _AllMatchesViewState();
}

class _AllMatchesViewState extends BaseViewState<AllMatchesView> {
  final bloc = injection<VeepBloc>();
  final List<VeepEntity> veepEntity = [];

  @override
  void initState() {
    bloc.add(GetMatchDataEvent(userId: 1));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<VeepBloc>(
        create: (_) => bloc,
        child: BlocListener<VeepBloc, BaseState<VeepState>>(
          listener: (_, state) {
            if (state is MatchDataSuccessState) {
              setState(() {
                veepEntity.clear();
                veepEntity.addAll(state.output.map((e) => VeepEntity(
                    veepId: e.veepId!,
                    accountType: 1,
                    name: e.name,
                    distance: e.distance,
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
                    timeExpire: e.expireTime,
                    lastActive: e.lastActivated)));
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showVeepDialog(
                      veeper1: VeepEntity(
                          veepId: 2,
                          accountType: 1,
                          name: 'Kadin Dias',
                          designation: 'CTO',
                          distance: 7,
                          profileImage:
                              'https://media.istockphoto.com/id/1338134336/photo/headshot-portrait-african-30s-man-smile-look-at-camera.jpg?b=1&s=170667a&w=0&k=20&c=j-oMdWCMLx5rIx-_W33o3q3aW9CiAWEvv9XrJQ3fTMU='),
                      veeper2: VeepEntity(
                        veepId: 2,
                        accountType: 1,
                        name: 'Kadin Dias',
                        designation: 'CTO',
                        distance: 7,
                        profileImage: 'https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png'
                      ),
                      onSendMessage: (){
                        Navigator.pop(context);
                        widget.onSendMessage();
                      }
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin:   const EdgeInsets.only(left: 30, right: 30),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(28)),
                        border: Border.all(color: AppColors.colorBlue, width: 1)),
                    child: Center(
                      child: Text('Matches',
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.colorBlue,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (.7 / 1),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      shrinkWrap: true,
                      itemCount: veepEntity.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MatchCardUI(
                            veepEntity: veepEntity[index], onTapped: () {
                          Navigator.pushNamed(context, Routes.kDiscoverProfileView,
                              arguments: veepEntity[index]);
                        });
                      },
                    ),
                  ),
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
