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
  late VideoPlayerController _videoController;
  // シークバーの現在の値
  late double _currentSliderValue;
  // シークバーのドラッグ中フラグ
  late bool _isDraggingSlider;

  @override
  void initState() {
    super.initState();
    //ステータスバーを非表示にする
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // フルスクリーンで動画を再生するために、VideoPlayerControllerを引き継ぐ
    _videoController = widget.controller;
    // ループ再生
    _videoController.setLooping(true);
    // 動画の読み込み
    _currentSliderValue = 0.0;
    // シークバーのドラッグ中かどうか
    _isDraggingSlider = false;

    // シークバーの更新
    _videoController.addListener(() {
      if (_videoController.value.isPlaying && !_isDraggingSlider) {
        setState(() {
          _currentSliderValue =
              _videoController.value.position.inMilliseconds.toDouble();
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  // シークバーのドラッグ開始時の処理
  void _onSliderChangeStart(double value) {
    setState(() {
      _isDraggingSlider = true;
    });
  }

  // シークバーの値が変更された時の処理
  void _onSliderChanged(double value) {
    setState(() {
      _currentSliderValue = value.clamp(0.0, _videoController.value.duration.inMilliseconds.toDouble());
    });
  }

  // シークバーのドラッグ終了時の処理
  void _onSliderChangeEnd(double value) {
    setState(() {
      _isDraggingSlider = false;
      _videoController.seekTo(Duration(milliseconds: value.toInt()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 56, 56, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(56, 56, 56, 1),
        title: Text("戻る"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // フルスクリーンを終了して元の画面に戻る
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
            // シークバー
            SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.white, // つまみの色を白に変更
                activeTrackColor: Colors.grey[400],   // 進んだ部分の色を灰色に変更 
                inactiveTrackColor: Colors.grey[600], // 進んでいない部分の色を灰色に変更
              ),
              child: Slider(
                value: _currentSliderValue,
                min: 0.0,
                max: _videoController.value.duration.inMilliseconds.toDouble(),
                onChanged: _onSliderChanged,
                onChangeStart: _onSliderChangeStart,
                onChangeEnd: _onSliderChangeEnd,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 動画の再生ボタン
                IconButton(
                  icon: Icon(Icons.play_arrow,color: Colors.white,size: 35),
                  onPressed: () {
                    _videoController.play();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                // 動画の一時停止ボタン
                IconButton(
                  icon: Icon(Icons.pause,color: Colors.white,size: 35),
                  onPressed: () {
                    _videoController.pause();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                // 動画の再生速度を変更するボタン
                PopupMenuButton<double>(
                  onSelected: (double value) {
                    _videoController.setPlaybackSpeed(value);
                  },
                  icon: Icon(Icons.speed,color: Colors.white,size: 35),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<double>(
                      value: 0.5,
                      child: Text('0.5x'),
                    ),
                    const PopupMenuItem<double>(
                      value: 1.0,
                      child: Text('1.0x'),
                    ),
                    const PopupMenuItem<double>(
                      value: 1.5,
                      child: Text('1.5x'),
                    ),
                    const PopupMenuItem<double>(
                      value: 2.0,
                      child: Text('2.0x'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
