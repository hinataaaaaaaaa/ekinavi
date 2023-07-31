import 'dart:io';
import 'package:flutter/material.dart';
import 'package:navi_station/view/admin/stationInfo_add.dart';
import 'package:navi_station/view/admin/station_add.dart';
import 'package:navi_station/view/admin/prefectures_inser.dart';
import 'package:navi_station/view/admin/show_move.dart';

import '../../video.dart';
import '../test.dart';
import '../user/tag_show_logic.dart';
import 'folder_control.dart';
import 'move_add.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  String videoPath = '';
  String videoTitle = '';
  String start = '';
  String end = '';
  String method = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 2, 175, 203),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              // 須発地点入力フィールド
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.height * 0.2,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '出発地点',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true, // 背景を塗りつぶす
                    fillColor: Colors.white,
                  ),
                  onChanged: (text) {
                    start = text;
                  },
                ),
              ),
              const SizedBox(height: 10),
              // 目的地入力フィールド
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.height * 0.2,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '目的地',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true, // 背景を塗りつぶす
                    fillColor: Colors.white,
                  ),
                  onChanged: (text) {
                    end = text;
                  },
                ),
              ),
              const SizedBox(height: 10),
              // 手段入力フィールド
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.height * 0.2,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '手段',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true, // 背景を塗りつぶす
                    fillColor: Colors.white,
                  ),
                  onChanged: (text) {
                    method = text;
                  },
                ),
              ),
              const SizedBox(height: 10),

              Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: videoPath.isEmpty
                      ? const Center(child: Text('動画を選択してください'))
                      // : Center(child: Text(videoPath))),
                      : Video(videoPath: File(videoPath))),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(width: 50),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        videoPath = '';
                      });
                      FolderControl().getVideoPath().then((path) => {
                            setState(() {
                              videoPath = path[0];
                              videoTitle = path[1];
                            })
                          });
                    },
                    child: const Text('動画を選択'),
                  ),
                ),
                const SizedBox(width: 70),
                ElevatedButton(
                  onPressed: () {
                    MoveAdd(start, end, method, videoTitle, videoPath);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('投稿'),
                ),
                const SizedBox(width: 40),
              ]),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ShowMove()));
                },
                child: const Text('show'),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 'test'ボタンが押された場合の処理
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => videoSelect()),
                      );
                    },
                    child: const Text('test'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 'ffff'ボタンが押された場合の処理
                      prefecture();
                    },
                    child: const Text('ffff'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 'ffff'ボタンが押された場合の処理
                      Tag tags = Tag();
                      stationAdd fa = stationAdd();
                      stationInfoAdd st = stationInfoAdd();
                      // tags.StartNames();
                      // tags.StartTag();
                      // tags.TagIcon();
                      // fa.selectStationAdd();
                      st.busInfoAdd();
                      
                    },
                    child: const Text('station'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            // _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}
