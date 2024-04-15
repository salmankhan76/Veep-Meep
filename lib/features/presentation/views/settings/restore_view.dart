import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/common/app_subtitle_text.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../../common/app_text_field.dart';
import '../base_view.dart';

class RestoreView extends BaseView {
  @override
  State<RestoreView> createState() => _RestoreViewState();
}

class _RestoreViewState extends BaseViewState<RestoreView> {
  var bloc = injection<AuthBloc>();
  final confirmationNumberController = TextEditingController();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Restore',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSubText(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount?AppColors.colorBlue:AppColors.colorGray600,
                        subtitle:
                            'If you have created a new account and are looking to transfer your subscription from your old account, check your email receipt and enter your purchase confirmation below.'),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      hint: 'Enter confirmation number',
                      controller: confirmationNumberController,
                      hintFontSize: AppDimensions.kFontSize15,
                      hintFontWeight: FontWeight.w400,
                      borderColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorGray700,
                      hintColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorGray700,
                    ),
                    //Spacer(),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                        buttonColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        buttonText: 'Unsubscribe From All',
                        onTapButton: () {}),
                  ],
                ),
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
