import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class FileUploadProgressDialog extends StatefulWidget {
  @override
  _FileUploadProgressDialogState createState() =>
      _FileUploadProgressDialogState();
}

class _FileUploadProgressDialogState extends State<FileUploadProgressDialog> {
  double pValue = 0.0;
  bool fGateway = false;

  startTimer() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      try {
        setState(() {
          pValue = AppConstants.LOADING_PROGRESS;
        });
      } catch (e) {}
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        alignment: FractionalOffset.center,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: AppColors.fontColorWhite,
                  border: Border.all(color: AppColors.colorGreen),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'File Uploading',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.colorGreen),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 20,
                            child: pValue != 100
                                ? LinearProgressIndicator(
                                    value: pValue / 100,
                                    backgroundColor: AppColors.colorDisableWidget,
                                    valueColor: const AlwaysStoppedAnimation(
                                        AppColors.colorGreen),
                                  )
                                : const LinearProgressIndicator(
                                    backgroundColor: AppColors.colorDisableWidget,
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.colorGreen)),
                          ),
                          Text(
                            "${pValue.toStringAsFixed(0)}%",
                            textAlign: TextAlign.center,
                            style:  const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.fontColorWhite),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        pValue == 100 ? 'Processing' : 'Give us a moment!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.colorGreen),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
