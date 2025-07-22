import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../core/app_colors.dart';

class VideoPlayerContent extends StatefulWidget {
  static const routeName = '/videoPlayerContent';

  final LearningObjectModel learningObject;

  const VideoPlayerContent({Key? key, required this.learningObject})
      : super(key: key);

  @override
  State<VideoPlayerContent> createState() => _VideoPlayerContentState();
}

class _VideoPlayerContentState extends State<VideoPlayerContent> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _showBackButton = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.learningObject.urlObject));

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      allowFullScreen: false,
      materialProgressColors: ChewieProgressColors(
        handleColor: AppColors.white,
        playedColor: AppColors.colorDark,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // rotacionar tela na vertical
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  void toggleBackButtonVisibility(bool visible) {
    setState(() {
      _showBackButton = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          toggleBackButtonVisibility(!_showBackButton);
        },
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: _showBackButton ? Icon(Icons.arrow_back) : null,
            ),
            Chewie(
              controller: _chewieController,
            ),
          ],
        ),
      ),
    );
  }
}
