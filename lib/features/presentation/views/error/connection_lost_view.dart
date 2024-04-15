import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/utils/app_images.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../base_view.dart';

class ConnectionLostView extends BaseView {
  @override
  State<ConnectionLostView> createState() => _ConnectionLostViewState();
}

class _ConnectionLostViewState extends BaseViewState<ConnectionLostView> {
  var bloc = injection<AuthBloc>();


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.imgConnectionError,
                height: 250,
              ),
              const SizedBox(height: 50),
              Text(
                "Connection Lost",
                style: TextStyle(
                    fontSize: AppDimensions.kFontSize24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorGray800),
              ),
              const SizedBox(height: 10),
              Text(
                "Seems like what you are not connected to\n"
                    "the internet.Check your connection",
                style: TextStyle(
                    fontSize: AppDimensions.kFontSize16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorGray800),
              ),

              Center(
                child: Text(
                  "and try again.",
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorIconOuter),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: AppButton(
                  buttonText: 'Try Again',
                  onTapButton: () {},
                ),
              ),
            ],
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
