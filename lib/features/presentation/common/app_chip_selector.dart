
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class AppChipSelectorData {
  bool isSelected;
  bool isHovered;
  final String label;
  final int id;

  AppChipSelectorData(
      {this.isSelected = false, required this.label, required this.id, this.isHovered = false});
}

class AppChipSelector extends StatefulWidget {
  final List<AppChipSelectorData> dataList;
  final Function(AppChipSelectorData) selectedItem;

  AppChipSelector({required this.dataList, required this.selectedItem});

  @override
  _AppChipSelectorState createState() => _AppChipSelectorState();
}

class _AppChipSelectorState extends State<AppChipSelector> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.dataList
          .map(
            (item) => InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                if (!item.isSelected) {
                  widget.dataList.forEach((element) {
                    element.isSelected = false;
                  });
                  widget.dataList
                      .firstWhere((element) => element.label == item.label)
                      .isSelected = true;
                  widget.selectedItem(item);
                  setState(() {});
                }
              },
              child: MouseRegion(
                onEnter: (e){
                  setState(() {
                    item.isHovered = true;
                  });
                },
                onExit: (e){
                  setState(() {
                    widget.dataList.forEach((element) {element.isHovered = false;});
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 5, top: 5),
                  child: Chip(
                    padding: EdgeInsets.all(10),
                    backgroundColor: item.isSelected
                        ? AppColors.colorPrimary
                        : item.isHovered
                            ? AppColors.colorHover
                            : AppColors.colorDisableWidget,
                    label: Text(
                      item.label,
                      style: TextStyle(
                          color: item.isSelected
                              ? AppColors.fontColorWhite
                              : item.isHovered
                                  ? AppColors.fontColorWhite
                                  : AppColors.colorPrimary,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
