import 'package:flutter/material.dart';

import '../../main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //ボタンが押されたかどうか
  bool _startisPressed = false;
  //ボタンが押されたかどうか
  bool _goalisPressed = false;
  // 色を変える変数
  bool _isColor = false;
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
    [
      '改札1',
      '改札2',
      '改札3',
      '改札4',
      '改札5',
      '改札6',
    ],
    [
      '出口1',
      '出口2',
      '出口3',
      '出口4',
      '出口5',
      '出口6',
    ],
    [
      'バス停1',
      'バス停2',
      'バス停3',
      'バス停4',
      'バス停5',
      'バス停6',
    ],
  ];

  List<List<String>> goal = [
    [
      '改札1',
      '改札2',
      '改札3',
      '改札4',
      '改札5',
      '改札6',
    ],
    [
      '出口1',
      '出口2',
      '出口3',
      '出口4',
      '出口5',
      '出口6',
    ],
    [
      'バス停1',
      'バス停2',
      'バス停3',
      'バス停4',
      'バス停5',
      'バス停6',
    ],
    [
      '案内所1',
      '案内所2',
      '案内所3',
      '案内所4',
      '案内所5',
      '案内所6',
    ],
    [
      'トイレ1',
      'トイレ2',
      'トイレ3',
      'トイレ4',
      'トイレ5',
      'トイレ6',
    ],
    [
      'お土産1',
      'お土産2',
      'お土産3',
      'お土産4',
      'お土産5',
      'お土産6',
    ],
  ];

  // ボタンの名前の配列
  List<String> startname = [
    '改札',
    '出口',
    'バス停',
  ];

  List<String> goalname = [
    '改札',
    '出口',
    'バス停',
    '案内所',
    'トイレ',
    'お土産',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 40,
          icon: ImageIcon(AssetImage('images/tag/return.png')),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
        actions: [
          IconButton(
            iconSize: 40,
            icon: ImageIcon(AssetImage('images/tag/help.png')),
            //TODO:押したときの処理追加
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
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
                height: 120,
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
                        primary: _isColor
                            ? Color.fromRGBO(206, 255, 161, 1)
                            : Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: Size(115, 40),
                        side: const BorderSide(
                          width: 2,
                          color: Color.fromRGBO(83, 137, 107, 1),
                        )),
                    onPressed: () {
                      setState(() {
                        _startisPressed = true;
                        _isColor = true;
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
                        primary: _isColor
                            ? Color.fromRGBO(206, 255, 161, 1)
                            : Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: Size(115, 40),
                        side: const BorderSide(
                          width: 2,
                          color: Color.fromRGBO(83, 137, 107, 1),
                        )),
                    onPressed: () {
                      setState(() {
                        _startisPressed = true;
                        _isColor = true;
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
                        primary: _isColor
                            ? Color.fromRGBO(206, 255, 161, 1)
                            : Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: Size(115, 40),
                        side: const BorderSide(
                          width: 2,
                          color: Color.fromRGBO(83, 137, 107, 1),
                        )),
                    onPressed: () {
                      setState(() {
                        _startisPressed = true;
                        _isColor = true;
                        sval = 2;
                      });
                    },
                  ),
                ]),
              ),
              if (_startisPressed)
                Container(
                  height: 120,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          child: Text(start[sval][0]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(start[sval][1]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(start[sval][2]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          child: Text(start[sval][3]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(start[sval][4]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(start[sval][5]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                            primary: _isColor
                                ? Color.fromRGBO(206, 255, 161, 1)
                                : Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            )),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _isColor = true;
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
                            primary: _isColor
                                ? Color.fromRGBO(206, 255, 161, 1)
                                : Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            )),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _isColor = true;
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
                            primary: _isColor
                                ? Color.fromRGBO(206, 255, 161, 1)
                                : Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            )),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _isColor = true;
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
                            primary: _isColor
                                ? Color.fromRGBO(206, 255, 161, 1)
                                : Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            )),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _isColor = true;
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
                            primary: _isColor
                                ? Color.fromRGBO(206, 255, 161, 1)
                                : Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            )),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _isColor = true;
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
                            primary: _isColor
                                ? Color.fromRGBO(206, 255, 161, 1)
                                : Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(115, 40),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(83, 137, 107, 1),
                            )),
                        onPressed: () {
                          setState(() {
                            _goalisPressed = true;
                            _isColor = true;
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
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          child: Text(goal[gval][0]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(goal[gval][1]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(goal[gval][2]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                      Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          child: Text(goal[gval][3]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(goal[gval][4]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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
                        OutlinedButton(
                          child: Text(goal[gval][5]),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            fixedSize: Size(115, 40),
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

          const SizedBox(
            height: 30,
          ),
          Container(
            width: 390,
            child: Text(
              '動画',
              style: TextStyle(fontSize: 20),
            ),
            color: Color.fromRGBO(201, 255, 182, 1),
          ),
          //TODO:動画とnavigationbar追加
        ],
      ),
    );
  }
}
