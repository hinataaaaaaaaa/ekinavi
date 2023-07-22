import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navi_station/logic/folder_control.dart';
import 'package:video_player/video_player.dart';
import 'package:navi_station/view/admin/components/admin_tag.dart';
import 'package:navi_station/view/full_screen_page.dart';


class VideoSelect extends StatefulWidget {
  const VideoSelect({Key? key}) : super(key: key);

  @override
  _VideoSelectState createState() => _VideoSelectState();
}

class _VideoSelectState extends State<VideoSelect> with SingleTickerProviderStateMixin {
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
    // 動画コントローラーの初期化
    _initializeVideoController();
    // タブコントローラーの初期化
    _tabController = TabController(
      initialIndex: 1,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose(); // タブコントローラーの破棄
    _controller?.dispose();    // 動画コントローラーの破棄
  }

  // 動画コントローラーの初期化
  void _initializeVideoController() {
    if (videoPath.isNotEmpty) {
      _controller = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          setState(() {
            _startUpdatingSeekBar();
          });
        });
    }
  }

  // シークバーの更新
  void _startUpdatingSeekBar() {
    // シークバーの更新を定期的に行う
    if (_controller!.value.isPlaying) {
      setState(() {
        _currentSeekBarValue = _controller!.value.position.inMilliseconds.toDouble();
      });
    }
    Future.delayed(const Duration(milliseconds: 200), _startUpdatingSeekBar);
  }

  // フルスクリーン再生
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

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 255, 245),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          AdminTagWidget(),
          //外枠
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.05,
              height: MediaQuery.of(context).size.height / 3.09,
              margin: EdgeInsets.only(bottom: 2),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              //動画表示
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Container(
                //動画表示部分をタップしたときにフルスクリーン再生
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFullScreen = true;
                      _playFullScreen();
                    }
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: videoPath.isEmpty
                        ? const Center(child: Text('動画を選択してください'))
                        : _controller != null && _controller!.value.isInitialized
                            ? Stack(
                                children: [
                                  VideoPlayer(_controller!),
                                  if (!isPlayFlag) 
                                    Center(
                                      child: IconButton(
                                        iconSize: 50,
                                        icon: Icon(Icons.play_arrow),
                                        onPressed: () {
                                          setState(() {
                                            isPlayFlag = true;
                                            _controller!.play();
                                          });
                                        },
                                      ),
                                    ),
                                  Positioned(
                                    bottom: 0,
                                    child: Slider(
                                      value: _currentSeekBarValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _currentSeekBarValue = value;
                                          _controller!.seekTo(Duration(milliseconds: value.toInt()));
                                        });
                                      },
                                      min: 0.0,
                                      max: _controller!.value.duration.inMilliseconds.toDouble(),
                                      activeColor: const Color.fromARGB(255, 171, 234, 173),
                                    ),
                                  ),
                                ],
                              )
                            : Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
                  //動画操作ボタン
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 35,
                        icon: isPlayFlag ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                        onPressed: () {
                          setState(() {
                            isPlayFlag = !isPlayFlag;
                            if (isPlayFlag) {
                              _controller?.play();
                            } else {
                              _controller?.pause();
                            }
                          });
                        },
                      ),
                      //動画選択ボタン
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3, right: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            side: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              videoPath = '';
                            });
                            FolderControl().getVideoPath().then((path) {
                              setState(() {
                                videoPath = path;
                                _initializeVideoController(); 
                              });
                            });
                          },
                          child: const Text('動画を選択'),
                        ),
                      ),
                      //メニューボタン
                      IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        // Show the vertical overflow menu
                        _showOverflowMenu();
                      },
                    )],
                  ),
                ],
              ),
            ),
            //アップロードボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('アップロード'),
                  ),
                ]),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      // エラーが発生した場合の処理
      print(e);
      return Scaffold(
        body: Center(
          child: Text('An error occurred: $e'),
        ),
      );
    }
  }

  //再生速度の設定 
  Future<void> _showOverflowMenu() async{
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.speed),
                title: Text('再生速度'),
                trailing: 
                DropdownButton<double>(
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