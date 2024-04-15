import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_state.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_no_data_component.dart';
import '../../common/app_progress_widget.dart';
import '../base_view.dart';

class PDFViewArgs {
  final String filePath;
  final String fileName;

  PDFViewArgs({required this.filePath, required this.fileName});
}

class PDFView extends BaseView {
  final PDFViewArgs args;

  PDFView({required this.args});

  @override
  State<PDFView> createState() => _PastPapersViewState();
}

class _PastPapersViewState extends BaseViewState<PDFView> {
  var bloc = injection<AuthBloc>();
  PDFViewController? _pdfViewController;
  int totalPDFPages = 0;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: VeepMeepAppBar(),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: AppProgressWidget(
            fileUrl: widget.args.filePath,
            isFileAvailable: _pdfViewController != null,
            onLoadCompleted: (filePath) async {
              await DefaultCacheManager().getSingleFile(
                widget.args.filePath,
              );
            },
            child: Stack(
              alignment: Alignment.topRight,
              fit: StackFit.expand,
              children: [
                PDF(
                    enableSwipe: false,
                    swipeHorizontal: true,
                    onPageChanged: (i, total) {
                      setState(() {
                        totalPDFPages = total ?? 1;
                      });
                    },
                    onViewCreated: (controller) async {
                      _pdfViewController = controller;
                      await _pdfViewController!.getPageCount().then((value) {
                        setState(() {
                          totalPDFPages = value ?? 1;
                        });
                      });
                    }).cachedFromUrl(
                  widget.args.filePath,
                  placeholder: (progress) => Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                        strokeWidth: 2,
                        value: progress / (100),
                        backgroundColor: AppColors.fontLabelGray,
                      ),
                    ),
                  ),
                  errorWidget: (error) => Center(
                    child: NoDataUI(),
                  ),
                ),
                _pdfViewController != null && totalPDFPages > 1
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Wrap(
                            children: [
                              InkResponse(
                                child: const Icon(
                                  Icons.arrow_circle_left,
                                  size: 40,
                                ),
                                onTap: () async {
                                  int? current = await _pdfViewController!
                                      .getCurrentPage();
                                  if (current != 0) {
                                    _pdfViewController!.setPage(current! - 1);
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              InkResponse(
                                child: const Icon(
                                  Icons.arrow_circle_right,
                                  size: 40,
                                ),
                                onTap: () async {
                                  int? current = await _pdfViewController!
                                      .getCurrentPage();
                                  int? total =
                                      await _pdfViewController?.getPageCount();
                                  if (current! <= total!) {
                                    _pdfViewController?.setPage(current + 1);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      // ignore: prefer_const_constructors
                      child: CircleAvatar(
                        backgroundColor: AppColors.fontColorDark,
                        radius: 22,
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.fontColorWhite,
                          child: Icon(
                            Icons.close,
                            color: AppColors.fontColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
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
