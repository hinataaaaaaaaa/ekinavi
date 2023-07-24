import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFullScreen extends StatefulWidget {
  final VideoPlayerController controller;
  VideoPlayerFullScreen({required this.controller});

  @override
  _VideoPlayerFullScreenState createState() => _VideoPlayerFullScreenState();
}

class _VideoPlayerFullScreenState extends State<VideoPlayerFullScreen> {

  @override
  void initState() {
    super.initState();
    widget.controller.setLooping(true);
    widget.controller.play();
  }

  @override
  void dispose() {
    widget.controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 102, 246, 97).withOpacity(0.5),
        title: Text("戻る"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // フルスクリーンを終了して元の画面に戻る
          },
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
      ),
    );
  }
}
