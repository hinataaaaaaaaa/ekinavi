import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Video extends StatefulWidget {
  File videoPath;
  Video({required this.videoPath, super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController controller;
  bool play = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videoPath);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Stack(
          children: [
            VideoPlayer(controller),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.play();
                          play = true;
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: play ? Colors.grey[700] : Colors.red,
                        )),
                    IconButton(
                        onPressed: () {
                          controller.pause();
                          play = false;
                        },
                        icon: Icon(
                          Icons.pause,
                          size: 50,
                          color: play ? Colors.red : Colors.grey[700],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
