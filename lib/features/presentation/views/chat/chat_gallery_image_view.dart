import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:veep_meep/utils/app_mediaQuery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:veep_meep/features/presentation/views/chat/utils/imageProvider.dart';

class ChatGalleryImageView extends StatefulWidget {
  const ChatGalleryImageView({Key? key}) : super(key: key);

  @override
  State<ChatGalleryImageView> createState() => _ChatGalleryImageViewState();
}

class _ChatGalleryImageViewState extends State<ChatGalleryImageView> {
  bool _singlePick = false;
  List<PickedAssetModel> _selectedMedia = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<PickerDataProvider>(
        create: (_) => PickerDataProvider(),
        child: Consumer<PickerDataProvider>(
          builder: (context, media, _) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    height: kheight(context) * 0.3,
                    color: Colors.black,
                    child: _selectedMedia.isEmpty
                        ? Container(
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 8,
                                  child: Icon(
                                    IonIcons.albums,
                                    color: Colors.white,
                                    size: kwidth(context) * 0.02,
                                  ),
                                ),
                                SizedBox(height: kheight(context) * 0.05),
                                const Text(
                                  'No media selected',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(kwidth(context) * 0.03),
                            child: PageView.builder(
                              itemCount: _selectedMedia.length,
                              itemBuilder: (context, index) {
                                final data = _selectedMedia[index];
                                if (data.type == 'image') {
                                  return Center(
                                    child: PhotoView.customChild(
                                      enablePanAlways: true,
                                      maxScale: 2.0,
                                      minScale: 1.0,
                                      child: Image.file(File(data.path)),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                  ),
                  Expanded(
                    child: GalleryMediaPicker(
                      mediaPickerParams: MediaPickerParamsModel(
                        appBarHeight: kwidth(context) * 0.15,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        thumbnailQuality: 200,
                        singlePick: _singlePick,
                        thumbnailBoxFix: BoxFit.cover,
                        imageBackgroundColor: Colors.black,
                        selectedCheckColor: Colors.black87,
                        selectedBackgroundColor: Colors.black,
                        gridViewBackgroundColor: Colors.grey,
                        selectedCheckBackgroundColor: Colors.white10,
                        appBarLeadingWidget: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: kwidth(context) * 0.04,
                              bottom: kwidth(context) * 0.01,
                              top: kwidth(context) * 0.02,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: kheight(context) * 0.07,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _singlePick = !_singlePick;
                                            });
                                            debugPrint(_singlePick.toString());
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                kwidth(context) * 0.01,
                                              ),
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                kwidth(context) * 0.03,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Select multiple',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        kwidth(context) * 0.05,
                                                  ),
                                                  Transform.scale(
                                                    scale: 1.5,
                                                    child: Icon(
                                                      _singlePick
                                                          ? Icons
                                                              .check_box_outline_blank
                                                          : Icons
                                                              .check_box_outlined,
                                                      color: Colors.blue,
                                                      size: kwidth(context) *
                                                          0.03,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      pathList: (List<PickedAssetModel> paths) {
                        setState(() {
                          _selectedMedia = paths;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
