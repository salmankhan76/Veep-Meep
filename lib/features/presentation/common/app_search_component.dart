import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_dimensions.dart';
import 'appbar.dart';

class AppSearchCriteria {
  final List<String> dataset;
  final Function(String) onSubmit;
  final String defaultValue;
  final String title;

  AppSearchCriteria(
      {required this.dataset,
      required this.onSubmit,
      required this.defaultValue,
      this.title = 'Search'});
}

class AppSearchComponent extends StatefulWidget {
  final AppSearchCriteria searchCriteria;

  AppSearchComponent({
    required this.searchCriteria,
  });

  @override
  _AppSearchComponentState createState() => _AppSearchComponentState();
}

class _AppSearchComponentState extends State<AppSearchComponent> {
  TextEditingController _searchController = TextEditingController();
  List<String> _filteredList = [];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchCriteria.defaultValue ?? '';
    _filteredList.addAll(widget.searchCriteria.dataset);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(padding: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: AppColors.colorGray50,
                  border: Border.all(color: AppColors.fontColorDark)
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _filteredList.clear();
                          _filteredList.addAll(widget.searchCriteria.dataset
                              .where((element) => element
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()))
                              .toList());
                        });
                      },
                      child: const SizedBox(
                        height: 42,
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: AppColors.fontColorDark,size: 20,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        maxLines: 1,
                        controller: _searchController,
                        onChanged: (query) {
                          setState(() {
                            _filteredList.clear();
                            _filteredList.addAll(widget.searchCriteria.dataset
                                .where((element) => element
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                .toList());
                          });
                        },
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 25,
                        onSubmitted: widget.searchCriteria.onSubmit,
                        style:TextStyle(
                          fontSize: AppDimensions.kFontSize14,
                          fontWeight: FontWeight.w400,
                           color: AppColors.fontColorDark,
                        ),

                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            counterText: "",
                            enabledBorder: InputBorder.none,

                            border:  InputBorder.none,
                            filled: true,
                            hintStyle: TextStyle(
                                color: AppColors.fontColorDark,
                                fontSize: AppDimensions.kFontSize16),
                            hintText: 'Search',
                            fillColor: Colors.transparent),
                      ),
                    ),


                  ],
                ),
              ),
              /*Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _filteredList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.searchCriteria.onSubmit(_filteredList[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        margin: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _filteredList[index],
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            (widget.searchCriteria.defaultValue != null &&
                                    widget.searchCriteria.defaultValue ==
                                        _filteredList[index])
                                ? const Icon(
                                    CupertinoIcons.checkmark_circle_fill,
                                    color: AppColors.colorSuccess,
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
