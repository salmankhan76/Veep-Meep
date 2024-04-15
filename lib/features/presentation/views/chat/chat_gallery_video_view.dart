import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:veep_meep/features/presentation/views/chat/utils/imageProvider.dart';
import 'package:veep_meep/utils/app_mediaQuery.dart';
import 'package:video_player/video_player.dart';

class ChatGalleryVideosView extends StatefulWidget {
  const ChatGalleryVideosView({Key? key}) : super(key: key);

  @override
  _ChatGalleryVideosViewState createState() => _ChatGalleryVideosViewState();
}

class _ChatGalleryVideosViewState extends State<ChatGalleryVideosView> {
  bool _singlePick = false;
  List<File> _selectedVideos = [];
  late VideoPlayerController _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
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
                    height: kheight(context) * 0.8,
                    color: Colors.black,
                    child: _selectedVideos.isEmpty
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
                                    Icons.video_library,
                                    color: Colors.white,
                                    size: kwidth(context) * 0.02,
                                  ),
                                ),
                                SizedBox(height: kheight(context) * 0.05),
                                const Text(
                                  'No videos selected',
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
                              itemCount: _selectedVideos.length,
                              itemBuilder: (context, index) {
                                final videoFile = _selectedVideos[index];
                                return AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: VideoPlayer(_videoPlayerController),
                                );
                              },
                            ),
                          ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _pickVideos,
                          child: Text('Select Videos'),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _selectedVideos.length,
                            itemBuilder: (context, index) {
                              final videoFile = _selectedVideos[index];
                              return ListTile(
                                title: Text(videoFile.path),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _selectedVideos.removeAt(index);
                                      if (_selectedVideos.isEmpty) {
                                        _videoPlayerController.pause();
                                      } else {
                                        _videoPlayerController =
                                            VideoPlayerController.file(
                                          File(_selectedVideos[0].path!),
                                        );
                                        _initializeVideoPlayerFuture =
                                            _videoPlayerController.initialize();
                                        _videoPlayerController.play();
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  Future<void> _pickVideos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: !_singlePick,
    );

    if (result != null && result.files.isNotEmpty) {
      List<PlatformFile> files = result.files;
      setState(() {
        _selectedVideos = files.map((file) => File(file.path!)).toList();
        if (_selectedVideos.isNotEmpty) {
          _videoPlayerController = VideoPlayerController.file(
            _selectedVideos[0],
          );
          _initializeVideoPlayerFuture = _videoPlayerController.initialize();
          _videoPlayerController.play();
        }
      });
    }
  }
}
