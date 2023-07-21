import 'package:flutter/material.dart';
import 'package:navi_station/logic/folder_control.dart';
// import 'package:videoselect/video.dart';
import 'package:video_player/video_player.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'dart:io';
import 'package:navi_station/view/admin/components/tag.dart';


class VideoSelect extends StatefulWidget {
  const VideoSelect({Key? key}) : super(key: key);

  @override
  _VideoSelectState createState() => _VideoSelectState();
}

class _VideoSelectState extends State<VideoSelect> with SingleTickerProviderStateMixin {
  String videoPath = '';
  VideoPlayerController? _controller;
  // bool isFullScreen = false;
  bool isPlayFlag = false;
  TabController? _tabController;
  double playbackSpeed = 1.0; // デフォルトの再生速度は1.0（通常速度）


    //ボタンが押されたかどうか
  bool _startisPressed = false;
  //ボタンが押されたかどうか
  bool _goalisPressed = false;
  // 色を変える変数
  bool _startisColor = false;
  // 色を変える変数
  bool _goalisColor = false;
  //色を変える変数
  bool _accessisColor = false;
  // ボタンの名前を変える変数
  int snum = 0;
  // ボタンの名前を変える変数
  int sval = 0;
  // ボタンの名前を変える変数
  int gnum = 0;
  // ボタンの名前を変える変数
  int gval = 0;


  // 名前の配列
  List<List<String>> start = [
    ['改札1','改札2','改札3','改札4','改札5','改札6',],
    ['出口1','出口2','出口3','出口4','出口5','出口6',],
    ['バス停1','バス停2','バス停3','バス停4','バス停5','バス停6',],
  ];

  List<List<String>> goal = [
    ['改札1','改札2','改札3','改札4','改札5','改札6',],
    ['出口1','出口2','出口3','出口4','出口5','出口6',],
    ['バス停1','バス停2','バス停3','バス停4','バス停5','バス停6',],
    ['案内所1','案内所2','案内所3','案内所4','案内所5','案内所6',],
    ['トイレ1','トイレ2','トイレ3','トイレ4','トイレ5','トイレ6',],
    ['お土産1','お土産2','お土産3','お土産4','お土産5','お土産6',],
  ];

  // ボタンの名前の配列
  List<String> startname = ['改札','出口','バス停',];

  List<String> goalname = ['改札','出口','バス停','案内所','トイレ','お土産',];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 1,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    _controller?.dispose(); // Dispose the video controller when the widget is disposed.
  }

  void _initializeVideoController() {
    if (videoPath.isNotEmpty) {
      _controller = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          // Update the state once the video is initialized.
          setState(() {});
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
                      //出発  
          const Row(
            children: [
              ImageIcon(
                AssetImage('images/tag/start.png'),
                size: 40,
              ),
              Text(
                '出発',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Container(
            width: 380,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 2)),
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                height: 105,
                alignment: Alignment(-1.0, -1.0),
                child: Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: ImageIcon(AssetImage('images/tag/ticket_gate.png')),
                    label: Text(
                      startname[0],
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: _startisColor && sval == 0
                          ? Color.fromRGBO(206, 255, 161, 1)
                          : Colors.white,
                      onPrimary: Colors.black,
                      fixedSize: Size(115, 40),
                      side: const BorderSide(
                        width: 2,
                        color: Color.fromRGBO(83, 137, 107, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _startisPressed = true;
                        _startisColor = true;
                        sval = 0;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: ImageIcon(AssetImage('images/tag/exit.png')),
                    label: Text(
                      startname[1],
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: _startisColor && sval == 1
                          ? Color.fromRGBO(206, 255, 161, 1)
                          : Colors.white,
                      onPrimary: Colors.black,
                      fixedSize: Size(115, 40),
                      side: const BorderSide(
                        width: 2,
                        color: Color.fromRGBO(83, 137, 107, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _startisPressed = true;
                        _startisColor = true;
                        sval = 1;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: ImageIcon(AssetImage('images/tag/bus_stop.png')),
                    label: Text(
                      startname[2],
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: _startisColor && sval == 2
                          ? Color.fromRGBO(206, 255, 161, 1)
                          : Colors.white,
                      onPrimary: Colors.black,
                      fixedSize: Size(115, 40),
                      side: const BorderSide(
                        width: 2,
                        color: Color.fromRGBO(83, 137, 107, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _startisPressed = true;
                        _startisColor = true;
                        sval = 2;
                      });
                    },
                  ),
                ]),
              ),
              if (_startisPressed)
                Container(
                  height: 105,
                  child: Column(
                    children: [
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            start[sval][0],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _startisPressed = false;
                              snum = 0;
                              startname[sval] = start[sval][snum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            start[sval][1],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _startisPressed = false;
                              snum = 1;
                              startname[sval] = start[sval][snum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            start[sval][2],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _startisPressed = false;
                              snum = 2;
                              startname[sval] = start[sval][snum];
                            });
                          },
                        ),
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            start[sval][3],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _startisPressed = false;
                              snum = 3;
                              startname[sval] = start[sval][snum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            start[sval][4],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _startisPressed = false;
                              snum = 4;
                              startname[sval] = start[sval][snum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            start[sval][5],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _startisPressed = false;
                              snum = 5;
                              startname[sval] = start[sval][snum];
                            });
                          },
                        ),
                      ]),
                    ],
                  ),
                ),
            ],
          ),
          //目的地
          const Row(
            children: [
              ImageIcon(
                AssetImage('images/tag/goal.png'),
                size: 40,
              ),
              Text(
                '到着',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Container(
            width: 380,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 2)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              Container(
                height: 120,
                child: Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon:
                            ImageIcon(AssetImage('images/tag/ticket_gate.png')),
                        label: Text(
                          goalname[0],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: _goalisColor && gval == 0
                              ? Color.fromRGBO(206, 255, 161, 1)
                              : Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: Size(115, 40),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _goalisColor = true;
                            gval = 0;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon: ImageIcon(AssetImage('images/tag/exit.png')),
                        label: Text(
                          goalname[1],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: _goalisColor && gval == 1
                              ? Color.fromRGBO(206, 255, 161, 1)
                              : Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: Size(115, 40),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _goalisColor = true;
                            gval = 1;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon: ImageIcon(AssetImage('images/tag/bus_stop.png')),
                        label: Text(
                          goalname[2],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: _goalisColor && gval == 2
                              ? Color.fromRGBO(206, 255, 161, 1)
                              : Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: Size(115, 40),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _goalisColor = true;
                            gval = 2;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon:
                            ImageIcon(AssetImage('images/tag/information.png')),
                        label: Text(
                          goalname[3],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: _goalisColor && gval == 3
                              ? Color.fromRGBO(206, 255, 161, 1)
                              : Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: Size(115, 40),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _goalisColor = true;
                            gval = 3;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon: ImageIcon(AssetImage('images/tag/toilet.png')),
                        label: Text(
                          goalname[4],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: _goalisColor && gval == 4
                              ? Color.fromRGBO(206, 255, 161, 1)
                              : Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: Size(115, 40),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _goalisColor = true;
                            gval = 4;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon: ImageIcon(AssetImage('images/tag/gift_shop.png')),
                        label: Text(
                          goalname[5],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: _goalisColor && gval == 5
                              ? Color.fromRGBO(206, 255, 161, 1)
                              : Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: Size(115, 40),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _goalisColor = true;
                            gval = 5;
                          });
                        },
                      ),
                    ],
                  ),
                ]),
              ),
              if (_goalisPressed)
                Container(
                  height: 120,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            goal[gval][0],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _goalisPressed = false;
                              gnum = 0;
                              goalname[gval] = goal[gval][gnum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            goal[gval][1],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _goalisPressed = false;
                              gnum = 1;
                              goalname[gval] = goal[gval][gnum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            goal[gval][2],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _goalisPressed = false;
                              gnum = 2;
                              goalname[gval] = goal[gval][gnum];
                            });
                          },
                        ),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            goal[gval][3],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _goalisPressed = false;
                              gnum = 3;
                              goalname[gval] = goal[gval][gnum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            goal[gval][4],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _goalisPressed = false;
                              gnum = 4;
                              goalname[gval] = goal[gval][gnum];
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            goal[gval][5],
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _goalisPressed = false;
                              gnum = 5;
                              goalname[gval] = goal[gval][gnum];
                            });
                          },
                        ),
                      ]),
                    ],
                  ),
                ),
            ],
          ),

          //手段
          //TODO:アイコン変更
          const Row(
            children: [
              ImageIcon(
                AssetImage('images/tag/ticket_gate.png'),
                size: 40,
              ),
              Text(
                '手段',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Container(
            width: 380,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 2)),
            ),
          ),
          const SizedBox(height: 5),
              Container(
                height: 60,
                alignment: Alignment(-1.0, -1.0),
                child: Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: ImageIcon(AssetImage('images/tag/ticket_gate.png')),
                    label: Text(
                      "エレベータ",
                      style: TextStyle(color: Colors.black , fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: _accessisColor
                          ? Color.fromRGBO(206, 255, 161, 1)
                          : Colors.white,
                      onPrimary: Colors.black,
                      fixedSize: Size(140, 40),
                      side: const BorderSide(
                        width: 2,
                        color: Color.fromRGBO(83, 137, 107, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if(!_accessisColor){
                          _accessisColor = true;
                        }else{
                          _accessisColor = false;
                        } 
                      });
                    },
                  ),
                ]),
              ),
          //外枠
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              width: MediaQuery.of(context).size.width / 1.05,
              margin: EdgeInsets.only(top: 0 , bottom: 5),
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
                    margin: EdgeInsets.only(top: 10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: videoPath.isEmpty
                        ? const Center(child: Text('動画を選択してください'))
                        : _controller != null && _controller!.value.isInitialized
                            ? Stack(
                                children: [
                                  VideoPlayer(_controller!),
                                  // Video(videoPath: videoPath),
                                  if (!isPlayFlag) // Show a play button overlay when paused
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
                                    child:Slider(
                                      value: _controller != null ? _controller!.value.position.inMilliseconds.toDouble() : 0.0,
                                      onChanged: (value) {
                                        setState(() {
                                          _controller!.seekTo(Duration(milliseconds: value.toInt()));
                                        });
                                      },
                                      min: 0.0,
                                      max: _controller != null ? _controller!.value.duration.inMilliseconds.toDouble() : 0.0,
                                      activeColor: const Color.fromARGB(255, 171, 234, 173),
                                    ),
                                  ),
                                ],
                              )
                            : Center(child: CircularProgressIndicator()),
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
                        padding: const EdgeInsets.only(top: 3, bottom: 3, right: 15),
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
                                _initializeVideoController(); // Initialize the video controller when a video is selected.
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
                    ),
                    ],
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
        // //ナビゲーションバー
        // bottomNavigationBar: MotionTabBar(
        //   initialSelectedTab: "Upload",
        //   useSafeArea: true,
        //   labels: const ["Home", "Upload"],
        //   icons: const [
        //     Icons.home,
        //     Icons.upload,
        //   ],
        //   tabSize: 50,
        //   tabBarHeight: 50,
        //   textStyle: const TextStyle(
        //     fontSize: 15,
        //     color: Colors.black,
        //     fontWeight: FontWeight.w500,
        //   ),
        //   tabIconColor: Color.fromRGBO(173, 173, 173, 1),
        //   tabIconSize: 50.0,
        //   tabIconSelectedSize: 40.0,
        //   tabSelectedColor: Color.fromRGBO(129, 191, 107, 1),
        //   tabIconSelectedColor: Colors.white,
        //   tabBarColor: const Color.fromRGBO(201, 255, 182, 1.0),
        //   onTabItemSelected: (int value) {
        //     setState(() {
        //       _tabController!.index = value;
        //     });
        //   },
        // ),
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