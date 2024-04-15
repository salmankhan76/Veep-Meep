import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../domain/entities/checkbox_entity.dart';
import '../../../domain/entities/filters_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_container.dart';
import '../../common/app_subtitle_text.dart';
import '../../common/app_title_text.dart';
import '../../common/appbar.dart';
import '../base_view.dart';

class FiltersView extends BaseView {
  @override
  State<FiltersView> createState() => _FiltersViewState();
}

class _FiltersViewState extends BaseViewState<FiltersView> {
  var bloc = injection<AuthBloc>();

  bool? viewStyle = true;
  bool? continents = true;
  bool? offerings = true;
  double _value = 6;
  late final FiltersEntity filtersEntity;
  RangeValues _currentRangeValues = const RangeValues(20, 60);

  bool africa = false;
  bool korea = false;
  bool europe = false;
  bool southAmerica = false;
  bool australia = false;
  bool northAmerica = false;
  bool antarctica = false;

  bool dating = false;
  bool friendship = false;
  bool business = false;


  @override
  void initState() {
    filtersEntity = FiltersEntity(
        countryName: '',
        interested: '',
        gender: '',
        sexuality: '');

        super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: "Filters",
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("View Style",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorGray800),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: true,
                              groupValue: viewStyle,
                              activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                              onChanged: (value) {
                                setState(() {
                                  viewStyle = value as bool?;
                                });
                              }),
                          Text('Classic',
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.colorGray800),),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Radio(
                              value: false,
                              groupValue: viewStyle,
                              activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                              onChanged: (value) {
                                setState(() {
                                  viewStyle = value as bool?;
                                });
                              }),
                          Text('Gallery',
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.colorGray800),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Location",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorGray800)),
                  const SizedBox(height: 20),
                  AppContainer(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorGray700,
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Text("Current location ",
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorGray800)),
                            Text("(San Francisco)",
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorGray400),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTitleText( title: 'Distance',),

                            Text('30miles',style: TextStyle(fontSize:AppDimensions.kFontSize11,
                                color: AppColors.colorGray600 ),)
                          ],
                        ),
                        Slider(
                          value: _value,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          onChanged: ((value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                          max: 100,
                          min: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('30miles',style: TextStyle(fontSize:AppDimensions.kFontSize11,
                                color: AppColors.colorGray600 ),),
                            Text('100miles',style: TextStyle(fontSize:AppDimensions.kFontSize11,
                                color: AppColors.colorGray600 ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text("Include Offerings"),
                        AppTitleText(title: 'Include Offerings'),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                    value: true,
                                    groupValue: offerings,
                                    onChanged: (value) {
                                      setState(() {
                                        offerings = value as bool?;
                                      });
                                    }),
                                Text('No',style: TextStyle(fontSize:AppDimensions.kFontSize16,
                                    color: AppColors.colorGray800),)
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Radio(
                                    value: false,
                                    activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                    groupValue: offerings,
                                    onChanged: (value) {
                                      setState(() {
                                        offerings = value as bool?;
                                      });
                                    }),
                                Text('Yes',style: TextStyle(fontSize:AppDimensions.kFontSize16,
                                    color: AppColors.colorGray800),)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(title: 'Include other Continents'),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                    value: false,
                                    groupValue: continents,
                                    onChanged: (value) {
                                      setState(() {
                                        continents = value as bool?;
                                      });
                                    }),
                                Text('No',style: TextStyle(fontSize:AppDimensions.kFontSize16,
                                    color: AppColors.colorGray800),)
                              ],
                            ),
                            SizedBox(width: 20),
                            Row(
                              children: [
                                Radio(
                                    value: true,
                                    activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                    groupValue: continents,
                                    onChanged: (value) {
                                      setState(() {
                                        continents = value as bool?;
                                      });
                                    }),
                                Text('Yes',style: TextStyle(fontSize:AppDimensions.kFontSize16,
                                    color: AppColors.colorGray800),)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppContainer(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Currently, ",
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorGray800),),
                            Text("North America only",
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorGray400),),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                         Row(
                           children: [
                             Checkbox(
                                 visualDensity: const VisualDensity(
                                   horizontal: VisualDensity.minimumDensity,
                                   vertical: VisualDensity.minimumDensity,
                                 ),
                                 fillColor:  MaterialStateProperty.all(Colors.transparent),
                                 side: MaterialStateBorderSide.resolveWith((states) {
                                   if(states.contains(MaterialState.pressed)){
                                     return BorderSide(color:AppColors.colorBlue);
                                   }
                                   else{
                                     return BorderSide(color:AppColors.colorGray900);
                                   }
                                 }),
                                 activeColor: AppColors.fontColorWhite,
                                 checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                 shape: CircleBorder(),
                                 value: africa,
                                 onChanged: (value){
                                   setState(() {
                                     africa = value!;
                                   });
                                 }),
                             Text("Africa",style: TextStyle(
                                 fontSize: AppDimensions.kFontSize16,
                                 color: AppColors.colorGray800)),
                           ],
                         ),
                         SizedBox(width: 63),
                         Row(
                           children: [
                             Checkbox(
                                 visualDensity: const VisualDensity(
                                   horizontal: VisualDensity.minimumDensity,
                                   vertical: VisualDensity.minimumDensity,
                                 ),
                                 fillColor:  MaterialStateProperty.all(Colors.transparent),
                                 side: MaterialStateBorderSide.resolveWith((states) {
                                   if(states.contains(MaterialState.pressed)){
                                     return BorderSide(color:AppColors.colorBlue);
                                   }
                                   else{
                                     return BorderSide(color:AppColors.colorGray900);
                                   }
                                 }),
                                 activeColor: AppColors.fontColorWhite,
                                 checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                 shape: CircleBorder(),
                                 value: korea,
                                 onChanged: (value){
                                   setState(() {
                                     korea = value!;
                                   });
                                 }),
                             Text("Korea",style: TextStyle(
                                 fontSize: AppDimensions.kFontSize16,
                                 color: AppColors.colorGray800)),
                           ],
                         ),
                         ],
                        ),
                        SizedBox(height: 10),
                        Row(children: [
                          Row(
                            children: [
                              Checkbox(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  fillColor:  MaterialStateProperty.all(Colors.transparent),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    if(states.contains(MaterialState.pressed)){
                                      return BorderSide(color:AppColors.colorBlue);
                                    }
                                    else{
                                      return BorderSide(color:AppColors.colorGray900);
                                    }
                                  }),
                                  activeColor: AppColors.fontColorWhite,
                                  checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                  shape: CircleBorder(),
                                  value: europe,
                                  onChanged: (value){
                                    setState(() {
                                      europe = value!;
                                    });
                                  }),
                              Text("Europe",style: TextStyle(
                                  fontSize: AppDimensions.kFontSize16,
                                  color: AppColors.colorGray800)),
                            ],
                          ),
                          SizedBox(width:53),
                          Row(
                            children: [

                              Checkbox(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  fillColor:  MaterialStateProperty.all(Colors.transparent),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    if(states.contains(MaterialState.pressed)){
                                      return BorderSide(color:AppColors.colorBlue);
                                    }
                                    else{
                                      return BorderSide(color:AppColors.colorGray900);
                                    }
                                  }),
                                  activeColor: AppColors.fontColorWhite,
                                  checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                  shape: CircleBorder(),
                                  value: australia,
                                  onChanged: (value){
                                    setState(() {
                                      australia = value!;
                                    });
                                  }),
                              Text("Australia",style: TextStyle(
                                  fontSize: AppDimensions.kFontSize16,
                                  color: AppColors.colorGray800)),
                            ],
                          ),
                        ],),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                          Row(
                            children: [
                              Checkbox(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  fillColor:  MaterialStateProperty.all(Colors.transparent),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    if(states.contains(MaterialState.pressed)){
                                      return BorderSide(color:AppColors.colorBlue);
                                    }
                                    else{
                                      return BorderSide(color:AppColors.colorGray900);
                                    }
                                  }),
                                  activeColor: AppColors.fontColorWhite,
                                  checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                  shape: CircleBorder(),
                                  value: antarctica,
                                  onChanged: (value){
                                    setState(() {
                                      antarctica = value!;
                                    });
                                  }),
                              Text("Antarctica",style: TextStyle(
                                  fontSize: AppDimensions.kFontSize16,
                                  color: AppColors.colorGray800)),
                            ],
                          ),
                         ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [

                            Checkbox(
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                fillColor:  MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStateBorderSide.resolveWith((states) {
                                  if(states.contains(MaterialState.pressed)){
                                    return BorderSide(color:AppColors.colorBlue);
                                  }
                                  else{
                                    return BorderSide(color:AppColors.colorGray900);
                                  }
                                }),
                                activeColor: AppColors.fontColorWhite,
                                checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                shape: CircleBorder(),
                                value: northAmerica,
                                onChanged: (value){
                                  setState(() {
                                    northAmerica = value!;
                                  });
                                }),
                            Text("North America",style: TextStyle(
                                fontSize: AppDimensions.kFontSize16,
                                color: AppColors.colorGray800)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [

                            Checkbox(
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                fillColor:  MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStateBorderSide.resolveWith((states) {
                                  if(states.contains(MaterialState.pressed)){
                                    return BorderSide(color:AppColors.colorBlue);
                                  }
                                  else{
                                    return BorderSide(color:AppColors.colorGray900);
                                  }
                                }),
                                activeColor: AppColors.fontColorWhite,
                                checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                shape: CircleBorder(),
                                value: southAmerica,
                                onChanged: (value){
                                  setState(() {
                                    southAmerica = value!;
                                  });
                                }),
                            Text("South America",style: TextStyle(
                                fontSize: AppDimensions.kFontSize16,
                                color: AppColors.colorGray800)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(title: 'Interested'),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    fillColor:  MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStateBorderSide.resolveWith((states) {
                                      if(states.contains(MaterialState.pressed)){
                                        return BorderSide(color:AppColors.colorBlue);
                                      }
                                      else{
                                        return BorderSide(color:AppColors.colorGray900);
                                      }
                                    }),
                                    activeColor: AppColors.fontColorWhite,
                                    checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                    shape: CircleBorder(),
                                    value: dating,
                                    onChanged: (value){
                                      setState(() {
                                        dating = value!;
                                      });
                                     }
                                    ),
                                Text("Dating",style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    color: AppColors.colorGray800)),
                              ],
                            ),
                            SizedBox(width: 50),
                            Row(
                              children: [

                                Checkbox(
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    fillColor:  MaterialStateProperty.all(Colors.transparent),
                                         side: MaterialStateBorderSide.resolveWith((states) {
                                    if(states.contains(MaterialState.pressed)){
                                    return BorderSide(color:AppColors.colorBlue);
                                   }
                                   else{
                                   return BorderSide(color:AppColors.colorGray900);
                                  }
                                  }),
                                    activeColor: AppColors.fontColorWhite,
                                    checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                    shape: CircleBorder(),
                                    value: friendship,
                                    onChanged: (value){
                                      setState(() {
                                        friendship = value!;
                                      });
                                    }),
                                Text("Friendship",style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    color: AppColors.colorGray800)),
                              ],
                            ),
                          ],
                        ),
                            Row(
                          children: [

                            Checkbox(
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                fillColor:  MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStateBorderSide.resolveWith((states) {
                                  if(states.contains(MaterialState.pressed)){
                                    return BorderSide(color:AppColors.colorBlue);
                                  }
                                  else{
                                    return BorderSide(color:AppColors.colorGray900);
                                  }
                                }),
                                activeColor: AppColors.fontColorWhite,
                                checkColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                                shape: CircleBorder(),
                                value: business,
                                onChanged: (value){
                                  setState(() {
                                    business = value!;
                                  });
                                }),
                            Text("Business",style: TextStyle(
                                fontSize: AppDimensions.kFontSize16,
                                color: AppColors.colorGray800)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTitleText(title: 'Age'),
                            Text('20-26',style: TextStyle(
                                fontSize: AppDimensions.kFontSize11,color: AppColors.colorGray600)),
                          ],
                        ),
                        RangeSlider(
                            values: _currentRangeValues,
                            max: 100,
                            min: 0,
                            activeColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                      child: Column(
                    children: [
                      //Text("Gender"),
                      AppTitleText(title: 'Gender'),
                      SizedBox(height: 20,),
                      RadioListTile(
                        title: AppSubText(
                            subtitle: 'Female',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400),
                        value: "Female",
                        activeColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        groupValue: filtersEntity.gender,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: ((value) {
                          setState(() {
                            filtersEntity.gender = value.toString();
                          });
                        }),
                      ),
                      RadioListTile(
                        title: AppSubText(
                            subtitle: 'Male',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400),
                        value: "Male",
                        activeColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        groupValue: filtersEntity.gender,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: ((value) {
                          setState(() {
                            filtersEntity.gender = value.toString();
                          });
                        }),
                      ),

                      RadioListTile(
                        title: AppSubText(
                            subtitle: 'No-Binary',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400),
                        value: "No-Binary",
                        activeColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        groupValue: filtersEntity.gender,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: ((value) {
                          setState(() {
                            filtersEntity.gender = value.toString();
                          });
                        }),
                      ),

                      RadioListTile(
                        title: AppSubText(
                            subtitle: 'Transwoman',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400),
                        value: "Transwoman",
                        activeColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        groupValue: filtersEntity.gender,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: ((value) {
                          setState(() {
                            filtersEntity.gender = value.toString();
                          });
                        }),
                      ),

                      RadioListTile(
                        title: AppSubText(
                            subtitle: 'Transman',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400),
                        value: "Transman",
                        activeColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        groupValue: filtersEntity.gender,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: ((value) {
                          setState(() {
                            filtersEntity.gender = value.toString();
                          });
                        }),
                      ),

                      RadioListTile(
                        title: AppSubText(
                            subtitle: 'Other',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400),
                        value: "Other",
                        activeColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        groupValue: filtersEntity.gender,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: ((value) {
                          setState(() {
                            filtersEntity.gender = value.toString();
                          });
                        }),
                      ),
                    ],
                  ),),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      children: [
                        //Text("Sexuality"),
                        AppTitleText(title: 'Sexuality'),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Straight',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "Straight",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: filtersEntity.sexuality,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              filtersEntity.sexuality = value.toString();
                            });
                          }),
                        ),

                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Gay',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "Gay",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: filtersEntity.sexuality,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              filtersEntity.sexuality = value.toString();
                            });
                          }),
                        ),

                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Lesbian',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "Lesbian",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: filtersEntity.sexuality,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              filtersEntity.sexuality = value.toString();
                            });
                          }),
                        ),

                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Bisexual',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "Bisexual",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: filtersEntity.sexuality,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              filtersEntity.sexuality = value.toString();
                            });
                          }),
                        ),

                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Pansexual',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "Pansexual",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: filtersEntity.sexuality,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              filtersEntity.sexuality = value.toString();
                            });
                          }),
                        ),

                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Other',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "Other",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: filtersEntity.sexuality,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              filtersEntity.sexuality = value.toString();
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
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
