import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:veep_meep/features/presentation/bloc/veep/veep_bloc.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../domain/entities/veep_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/veep/veep_event.dart';
import '../../bloc/veep/veep_state.dart';
import '../base_view.dart';

class DiscoverProfileView extends BaseView {
  final VeepEntity veepEntity;

  DiscoverProfileView({required this.veepEntity});

  @override
  State<DiscoverProfileView> createState() => _DiscoverProfileViewState();
}

class _DiscoverProfileViewState extends BaseViewState<DiscoverProfileView> {
  var bloc = injection<VeepBloc>();
  final pageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    bloc.add(GetVeepDataEvent(userId: 1));
    super.initState();
  }

  _showShareOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
              child: Text(
            "Share",
            style: TextStyle(
                fontSize: AppDimensions.kFontSize24,
                color: AppColors.colorGray800,
                fontWeight: FontWeight.w700),
          )),
          content: SizedBox(
            height: 50,
            child: Column(
              children: [
                Text(
                  "Tap an icon below to share your",
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize16,
                      color: AppColors.colorGray700,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Text(
                  "content directly",
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize16,
                      color: AppColors.colorGray700),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset(
                      AppImages.icInstagram,
                      color: AppColors.colorGray800,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppImages.icFacebook,
                      color: AppColors.colorGray800,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppImages.icWhatsapp,
                      color: AppColors.colorGray800,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _showReportOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
              child: Text(
            "Report User",
            style: TextStyle(
                fontSize: AppDimensions.kFontSize24,
                color: AppColors.colorGray800,
                fontWeight: FontWeight.w700),
          )),
          content: SizedBox(
            height: 250.h,
            child: Column(
              children: [
                Text(
                  "Is this person bothering you? Tell us what they did.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize16,
                      color: AppColors.colorGray700,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorBorder,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Inappropriate Photos",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          color: AppColors.colorGray700,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorBorder,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Feels Like Spam",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          color: AppColors.colorGray700,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorBorder,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "User is underage",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          color: AppColors.colorGray700,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.colorBorder,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Other",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          color: AppColors.colorGray700,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildView(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkResponse(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.colorBackground,
            size: 30,
          ),
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(
                  color: AppColors.colorPrimary, thickness: 1),
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton<int>(
              position: PopupMenuPosition.under,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: AppColors.fontColorWhite,
              onSelected: (index) async {
                if (index == 0) {
                  final file = await DefaultCacheManager().getSingleFile(widget.veepEntity.images![pageIndex]);
                  Share.shareXFiles([XFile(file.path)]);
                  // _showShareOption();
                } else {
                  _showReportOption();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Center(
                    child: Text(
                      'Share',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize13,
                          color: AppColors.colorGray800,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 1,
                  child: Center(
                    child: Text(
                      'Report',
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize13,
                          color: AppColors.colorGray800,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocProvider<VeepBloc>(
        create: (_) => bloc,
        child: BlocListener<VeepBloc, BaseState<VeepState>>(
            listener: (_, state) {},
            child: Stack(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 2) + 50,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (value){
                            pageIndex = value;
                          },
                          itemCount: widget.veepEntity.images!.where((element) => element.isNotEmpty).length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              widget.veepEntity.images![index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: widget.veepEntity.images!.where((element) => element.isNotEmpty).length,
                          onDotClicked: (index){
                            pageIndex = index;
                          },
                          effect: const WormEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: AppColors.colorGray50,
                            strokeWidth: 1,
                            dotColor: AppColors.colorGray400,
                            paintStyle: PaintingStyle.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                /*    Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 36),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkResponse(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.colorBackground,
                            size: 30,
                          ),
                        ),
                        InkResponse(
                          onTapDown: (position) {
                            _showContextMenu(context);
                          },
                          child: const Icon(
                            Icons.more_horiz_sharp,
                            size: 30,
                            color: AppColors.colorBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.9,
                      decoration: const BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 27,
                                    child: Image.asset(AppImages.imgCloseBtn),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      CircleAvatar(
                                        radius: 43,
                                        child:
                                            Image.asset(AppImages.imgVeepBtn),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 27,
                                    child: Image.asset(AppImages.imgStartBtn),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppConstants.kIsBizAccount
                                        ? widget.veepEntity.serviceName ?? ''
                                        : widget.veepEntity!.name ?? '',
                                    style: TextStyle(
                                        fontSize: AppDimensions.kFontSize24,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.colorGray800),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppConstants.kIsBizAccount
                                            ? '${ widget.veepEntity.city!=null?'${ widget.veepEntity.city}, ':''}${ widget.veepEntity.country}'
                                            :  widget.veepEntity.designation!,
                                        style: TextStyle(
                                            fontSize: AppDimensions.kFontSize16,
                                            color: AppColors.colorGray800,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.location_on,
                                        color: AppColors.colorBlue,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${widget.veepEntity.distance} miles',
                                        style: TextStyle(
                                            fontSize: AppDimensions.kFontSize14,
                                            color: AppColors.colorGray800,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: AppColors.colorGray50,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        AppConstants.kIsBizAccount
                                            ? widget.veepEntity.slogan??''
                                            : widget.veepEntity.bio!,
                                        style: TextStyle(
                                            fontSize: AppDimensions.kFontSize14,
                                            color: AppColors.colorGray700,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: !AppConstants.kIsBizAccount,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: 'Gender : ',
                                          style: TextStyle(
                                            color: AppColors.colorGray700,
                                            fontSize: AppDimensions.kFontSize14,
                                            fontWeight: FontWeight.w400,),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: getGenderName(widget.veepEntity.gender??'1'),
                                              style: TextStyle(
                                                  fontSize: AppDimensions.kFontSize14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppConstants.kIsBizAccount
                                                      ? AppColors.colorGreen
                                                      : AppColors.colorBlue),
                                            )
                                          ]),
                                    ),
                                  ),
                                  _getSocialText(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  widget.veepEntity.hobbies!=null?Text(
                                    textAlign: TextAlign.start,
                                    "Hobbies",
                                    style: TextStyle(
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray800,
                                        fontWeight: FontWeight.w600),
                                  ):SizedBox.shrink(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  widget.veepEntity.hobbies!=null?Text(
                                    textAlign: TextAlign.start,
                                    widget.veepEntity.hobbies!,
                                    style: TextStyle(
                                        fontSize: AppDimensions.kFontSize14,
                                        color: AppColors.colorGray800,
                                        fontWeight: FontWeight.w500),
                                  ):const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  Widget _getSocialText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.veepEntity!.web != null &&
            widget.veepEntity!.web!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Website: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.veepEntity!.web!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (widget.veepEntity!.fb != null &&
            widget.veepEntity!.fb!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Facebook: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.veepEntity!.fb!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (widget.veepEntity.instagram != null &&
            widget.veepEntity.instagram!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Instagram: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.veepEntity.instagram!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (widget.veepEntity.linkedin != null &&
            widget.veepEntity.linkedin!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'LinkedIn: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.veepEntity.linkedin!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (widget.veepEntity.snapchat != null &&
            widget.veepEntity.snapchat!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Snapchat: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.veepEntity.snapchat!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (widget.veepEntity.twitter != null &&
            widget.veepEntity.twitter!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Twitter: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.veepEntity!.twitter!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
      ],
    );
  }

  String getGenderName(String genderValue) {
    switch (genderValue) {
      case '1':
        return 'Female';
      case '2':
        return 'Male';
      case '3':
        return 'Non-Binary';
      case '4':
        return 'Transwoman';
      case '5':
        return 'Transman';
      case '6':
        return 'You Decide';
      default:
        return '';
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
