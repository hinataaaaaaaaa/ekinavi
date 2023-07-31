import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../config/color_config.dart';
import '../full_screen_page.dart';

class ShowMove extends StatefulWidget {
  final String? routeName;
  final String? method;

  ShowMove({
    Key? key,
    required String routeKey,
    required String methodKey,
    this.routeName,
    this.method,
  }) : super(key: key ?? ValueKey('$routeKey:$methodKey'));

  @override
  State<ShowMove> createState() => _ShowMoveState();
}

class _ShowMoveState extends State<ShowMove> with SingleTickerProviderStateMixin {
  List<bool> playFlags = [];
  late Future<List<VideoPlayerController>> _controllerFuture;

  // 動画のパス
  String videoPath = '';
  // 動画コントローラー
  VideoPlayerController? _controller;
  //フルスクリーンかどうか
  bool _isFullScreen = false;
  // 動画が再生中かどうか
  bool isPlayFlag = false;
  // タブコントローラー
  TabController? _tabController;
  // シークバーの現在位置
  double _currentSeekBarValue = 0.0;
  // 再生速度
  double playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _controllerFuture = _initializeController(widget.routeName, widget.method);
  }

@override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController!.dispose();
    }
    if (_controller != null) {
      _controller!.dispose();
    }
  }

  Future<List<VideoPlayerController>> _initializeController(String? route, String? method) async {
    // TODO : 仮置き中
    // String videoPath = await getStreamingUrl(route, method);
    String videoPath = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    List<VideoPlayerController> controllers = [];

    if (videoPath.isNotEmpty) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoPath))
        ..initialize().then((_) {
          setState(() {
            // _startUpdatingSeekBar();
          });
        });

      print(videoPath);
      controllers.add(controller);
    }
    ;
    return controllers;
  }

  // シークバーの更新
  // void _startUpdatingSeekBar() {
  //   // シークバーの更新を定期的に行う
  //   if (_controller != null && _controller!.value.isPlaying) {
  //     setState(() {
  //       _currentSeekBarValue =
  //           _controller!.value.position.inMilliseconds.toDouble();
  //     });
  //   }
  //   Future.delayed(const Duration(milliseconds: 200), _startUpdatingSeekBar);
  // }

// フルスクリーン再生画面へ遷移
  void _playFullScreen() {
    if (_controller != null && _controller!.value.isInitialized) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerFullScreen(controller: _controller!),
        ),
      ).then((value) {
        setState(() {
          _controller!.pause();
          _isFullScreen = false;
        });
      });
    }
  }

  Future<String> getStreamingUrl(route, method) async {
    try {
      // StorageのReferenceを指定
      Reference ref = FirebaseStorage.instance.ref('guide/大阪府/大阪駅/$route');

      // 子要素を取得する
      ListResult result = await ref.list();

      // 子要素とタイトルを格納するためのMap
      Map<FullMetadata, Map<String, String>> downloadUrls = {};

      // 子要素を1つずつ取り出してリストに格納する
      for (var item in result.items) {
        String downloadURL = await item.getDownloadURL();
        FullMetadata metadata = await item.getMetadata();
        // カスタムメタデータの取得
        String title = metadata.customMetadata?['title'] ?? '';

        // ダウンロードURLとタイトルをMapとして格納
        Map<String, String> urlAndTitle = {
          'url': downloadURL,
          'title': title,
        };
        if (method == title) {
          downloadUrls[metadata] = urlAndTitle;
        }
      }
      String url = downloadUrls.values.first['url'] ?? '';
      downloadUrls.forEach((metadata, urlAndTitle) {
        String title = urlAndTitle['title'] ?? '';
      }); // 確認用
      return url;
    } catch (e) {
      print('e:${e.toString()}');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<VideoPlayerController>>(
        future: _controllerFuture,
        builder: (context, snapshot) {
          // Futureが完了したら、ビデオを表示
          if (snapshot.connectionState == ConnectionState.done) {
            // ビデオのリストを取得
            final controllerList = snapshot.data;
            if (controllerList != null && controllerList.isNotEmpty) {
              // 最初のVideoPlayerControllerを取得して_controllerに代入
              _controller = controllerList[0];
              return Container(
                width: MediaQuery.of(context).size.width / 1,
                margin: const EdgeInsets.only(bottom: 2),
                // decoration: ShapeDecoration(
                //   shape: RoundedRectangleBorder(
                //     side: const BorderSide(width: 1.5, color: Colors.grey),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
                //  動画表示
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFullScreen = true;
                            _playFullScreen();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                color: ColorConfig.mainColor,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(15),
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Stack(
                            children: [
                              VideoPlayer(_controller!), // 動画の表示
                            ],
                          ),
                        )),
                  ],
                ),
              );
            } else {
              return const Align(
                alignment: Alignment.center,
                child: Text(
                  '動画がありません',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // テキストの太さ
                    fontSize: 16, // テキストのサイズ
                    color: Colors.red, // テキストの色
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _showOverflowMenu() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.speed),
                title: const Text('再生速度'),
                trailing: DropdownButton<double>(
                  value: playbackSpeed,
                  items: const [
                    DropdownMenuItem(
                      value: 0.25,
                      child: Text('0.25x'),
                    ),
                    DropdownMenuItem(
                      value: 0.5,
                      child: Text('0.5x'),
                    ),
                    DropdownMenuItem(
                      value: 1.0,
                      child: Text('1.0x'),
                    ),
                    DropdownMenuItem(
                      value: 1.5,
                      child: Text('1.5x'),
                    ),
                    DropdownMenuItem(
                      value: 2.0,
                      child: Text('2.0x'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      playbackSpeed = value!;
                      _controller!.setPlaybackSpeed(playbackSpeed);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
