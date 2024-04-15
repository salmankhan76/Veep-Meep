import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class AppProgressWidget extends StatefulWidget {
  final String fileUrl;
  final Widget child;
  final bool isFileAvailable;
  final Function(String) onLoadCompleted;

  AppProgressWidget({
    required this.fileUrl,
    required this.child,
    required this.onLoadCompleted,
    this.isFileAvailable = false,
  });

  @override
  State<AppProgressWidget> createState() => _AppProgressWidgetState();
}

class _AppProgressWidgetState extends State<AppProgressWidget> {
  bool _isLoadComplete = false;

  @override
  void initState() {
    DefaultCacheManager().getSingleFile(widget.fileUrl).then((value) {
      if (value != null) {
        // widget.onLoadCompleted(value.path);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: DefaultCacheManager()
          .getFileStream(widget.fileUrl, withProgress: true),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data is DownloadProgress) {
          final progress = snapshot.data as DownloadProgress;
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 75,
                  height: 75,
                  child: CircularProgressIndicator(
                    color: AppColors.colorGreen,
                    value: progress.downloaded / (progress.totalSize ?? 100),
                    backgroundColor: AppColors.fontLabelGray,
                  ),
                ),
                Text(
                  '${((progress.downloaded / (progress.totalSize ?? 100)) * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      color: AppColors.colorGreen,
                      fontSize: AppDimensions.kFontSize18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          );
        } else {
          if (!_isLoadComplete &&
              !widget.isFileAvailable &&
              snapshot.data != null) {
            _isLoadComplete = true;
            if (snapshot.data != null) {
              widget.onLoadCompleted(snapshot.data!.originalUrl);
            }
          }
          return widget.child;
        }
      },
    );
  }
}
