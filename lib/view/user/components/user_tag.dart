import 'package:flutter/material.dart';

class UserTagWidget extends StatefulWidget {
  const UserTagWidget({Key? key}) : super(key: key);

  @override
  _UserTagWidgetState createState() => _UserTagWidgetState();
}

class _UserTagWidgetState extends State<UserTagWidget> {

  //ボタンが押されたかどうか
  bool _startisPressed = false;
  //ボタンが押されたかどうか
  bool _goalisPressed = false;
  // 色を変える変数
  bool _startisColor = false;
  // 色を変える変数
  bool _goalisColor = false;
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
  Widget build(BuildContext context) {
      return 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const SizedBox(height: 15),
        const Row(
            children: [
              ImageIcon(
                AssetImage('images/tag/start.png'),
                size: 40,
              ),
              Text(
                '出発',
                style: TextStyle(fontSize: 20 , fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
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
                      primary: _startisColor && sval == 0
                          ? Color.fromRGBO(206, 255, 161, 1)
                          : Colors.white,
                      onPrimary: Colors.black,
                      fixedSize: Size(125, 40),
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
                      fixedSize: Size(125, 40),
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
                      fixedSize: Size(125, 40),
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
                  height: 120,
                  color: Colors.white,
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
          const Row(
            children: [
              ImageIcon(
                AssetImage('images/tag/goal.png'),
                size: 40,
              ),
              Text(
                '到着',
                style: TextStyle(fontSize: 20 , fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
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
                          fixedSize: Size(125, 40),
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
                          fixedSize: Size(125, 40),
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
                          fixedSize: Size(125, 40),
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
                          fixedSize: Size(125, 40),
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
                          fixedSize: Size(125, 40),
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
                          fixedSize: Size(125, 40),
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
                  color: Colors.white,
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
                            fixedSize: Size(125, 40),
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
        ],
      );
  }
}