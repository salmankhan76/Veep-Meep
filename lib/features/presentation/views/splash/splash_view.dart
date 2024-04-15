import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:veep_meep/features/data/models/requests/user_identify_request.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_animations.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class SplashView extends BaseView {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseViewState<SplashView> {
  var bloc = injection<AuthBloc>();
  Color _color1 = AppColors.colorBlue;
  Color _color2 = AppColors.colorGreen;

  @override
  void initState() {
    if (appSharedData.hasEmailAddress() && appSharedData.hasUserId()) {
      bloc.add(
        IdentifyUserEvent(
          userIdentifyRequest: UserIdentifyRequest(
            userId: appSharedData.getUserId()!,
            emailAddress: appSharedData.getEmailAddress()!,
          ),
        ),
      );
    }

    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (appSharedData.hasLoginAvailable()) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.kHomeView, (route) => false);
      } else {
        Navigator.pushReplacementNamed(context, Routes.kIntroView);
      }
    });
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [_color2, _color1],
                  stops: [0, 0.8]),
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Lottie.asset(
                AppAnimations.animationLoopOut,
                fit: BoxFit.fill,
              ),
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
