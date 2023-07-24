import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowMove extends StatefulWidget {
  final String? n;

  const ShowMove(this.n, {Key? key}) : super(key: key);

  @override
  State<ShowMove> createState() => _ShowMoveState();
}

class _ShowMoveState extends State<ShowMove> with SingleTickerProviderStateMixin {
  List<bool> playFlags = [];
  late Future<List<VideoPlayerController>> _controllerFuture;

  @override
  void initState() {
    super.initState();
    _controllerFuture = _initializeController();
  }

  Future<List<VideoPlayerController>> _initializeController() async {
    List<String> videoUrls = await getStreamingUrl();
    List<VideoPlayerController> controllers = [];
    for (String videoUrl in videoUrls) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await controller.initialize();
      controllers.add(controller);
      playFlags.add(false);
    }
    return controllers;
  }

  Future<List<String>> getStreamingUrl() async {

// TODO;フォルダから複数枚の画像を取得して格納する
    try {
      // StorageのReferenceを指定
      Reference ref = FirebaseStorage.instance.ref('guide/大阪府/大阪駅/桜橋口~西出口');

      // 子要素を取得する
      ListResult result = await ref.list();

      // 子要素を格納するためのリスト
      List<String> downloadUrls = [];

      // 子要素を1つずつ取り出してリストに格納する
      for (var item in result.items) {
        String downloadURL = await item.getDownloadURL();
        downloadUrls.add(downloadURL);
      }

      // リストに格納された子要素を表示
      for (var url in downloadUrls) {
        print('子要素のダウンロードURL: $url');
      } // 確認用
      return downloadUrls;
    } catch (e) {
      print('e:${e.toString()}');
      return [];
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
            final controller = snapshot.data;
            if (controller != null) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // asMap()でindexを取得できる
                  children: controller.asMap().entries.map((entry) {
                    int index = entry.key;
                    VideoPlayerController controller = entry.value;
                    bool isPlaying = playFlags[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }
                          // playフラグを反転させる
                          playFlags[index] = !isPlaying;
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: VideoPlayer(controller),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Text('動画の読み込みに失敗しました');
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

  @override
  void dispose() {
    super.dispose();
    _controllerFuture.then((controllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    });
  }
}
