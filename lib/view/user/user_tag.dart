import 'package:flutter/material.dart';
import 'package:navi_station/view/user/main_page.dart';
import 'package:navi_station/view/user/tag_show_logic.dart';

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
  int? sval;
  // ボタンの名前を変える変数
  int? gval;

  // ボタンの名前の配列
  Tag tags = Tag();
  Map<String, dynamic> startNames = {}; // 出発地点の詳細を格納
  List<String> startName = []; // 出発地点を格納
  List<String> tmpStartName = []; // 一時的なリストを作成

  Map<String, dynamic> goalNames = {}; // 到着地点の詳細を格納
  List<String> goalName = []; // 到着地点を格納
  List<String> tmpGoalName = []; // 一時的なリストを作成

  Map<String, bool> sendCheckedList = {'出発': false, '到着': false}; // 送信確認用のリスト

  Map<String, dynamic> tagIcon = {}; // アイコンのパスを格納

  String n = '';
  // TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _fetchStartNames(); // 出発地点の名前を取得
    _fetchStartInfo(); // 出発地点の詳細を取得
    _fetchGoalNames(); // 出発地点の名前を取得
    _fetchGoalInfo(); // 出発地点の詳細を取得
    _fetchTagIcon(); // アイコンのパスを取得
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController!.dispose();
  }

// 出発地点の名前を取得
  Future<void> _fetchStartNames() async {
    List<String> names = await tags.StartNameTitle();
    setState(() {
      startName = names;
      tmpStartName = List.from(startName);
    });
  }

// 出発地点の詳細を取得
  Future<void> _fetchStartInfo() async {
    Map<String, dynamic> names = await tags.StartNameInfo();
    setState(() {
      startNames = names;
    });
  }

// 到着地点の名前を取得
  Future<void> _fetchGoalNames() async {
    List<String> names = await tags.GoalName();
    setState(() {
      goalName = names;
      tmpGoalName = List.from(goalName);
    });
  }

// 到着地点の詳細を取得
  Future<void> _fetchGoalInfo() async {
    Map<String, dynamic> names = await tags.GoalNames();
    setState(() {
      goalNames = names;
    });
  }

// アイコンのパスを取得
  Future<void> _fetchTagIcon() async {
    Map<String, dynamic> icon = await tags.TagIcon();
    setState(() {
      tagIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 15),
        // 出発地点選択
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
              alignment: const Alignment(-1.0, -1.0),
              child: Column(
                children: [
                  SizedBox(
                    child: Wrap(
                      children: [
                        for (int i = 0; i < tmpStartName.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (startNames[tmpStartName[i]].isNotEmpty) {
                                    _startisPressed = true; // ボタンが押されたかどうか
                                    _startisColor = true; // 色を変える変数
                                    sval = i; // ボタンの名前を変える変数
                                    sendCheckedList['出発'] = true;
                                    startName = List.from(
                                        tmpStartName); // tmpStartNameをstartNameにコピー(再表示用)
                                    print('wwwwwwwww${goalName[gval!]}');
                                  }
                                });
                              },
                              // ボタンのスタイル設定
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor: _startisColor && sval == i
                                    ? const Color.fromRGBO(206, 255, 161, 1)
                                    : Colors.white,
                                foregroundColor: Colors.black,
                                fixedSize: const Size(115, 40),
                                side: const BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(83, 137, 107, 1),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center, // テキストを中央に配置
                                children: [
                                  // 選択していないボタンのアイコンを表示
                                  if (sval != i)
                                    ImageIcon(
                                      AssetImage(
                                        // アイコンのパスを指定
                                        'images/tag/${tagIcon[tmpStartName[i]]}',
                                      ),
                                      color: Colors.black, // アイコンの色を指定
                                    ),
                                  // アイコンが表示される場合のみSizedBoxを追加
                                  if (sval != i) const SizedBox(width: 10),
                                  // 選択したボタンのテキストを表示
                                  Text(
                                    startName[i],
                                    style: TextStyle(
                                      color: Colors.black,
                                      // 駅名の文字数に応じてリサイズ
                                      fontSize:
                                          (startName[i].length > 4) ? 15 : 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ボタンが押されたときに表示される
            if (_startisPressed)
              Container(
                height: 120,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          // mapデータから駅名を取得
                          for (var key in startNames[startName[sval!]].keys)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  fixedSize: const Size(115, 40),
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
                                    _startisPressed = false; // ボタンが押されたかどうか
                                    startName[sval!] = key; // ボタンの名前を変える変数
                                    if (sendCheckedList['出発'] == true &&
                                        sendCheckedList['到着'] == true) {
                                      setState(() {
                                        n = '${startName[sval!]}~${goalName[gval!]}';
                                        print('wwwwwwwww${goalName[gval!]}');
                                      });
                                      sendCheckedList['出発'] = false;
                                    }
                                  });
                                },
                                child: Text(
                                  key,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    // 駅名の文字数に応じてリサイズ
                                    fontSize: (key.length > 4) ? 15 : 15,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
          ],
        ),

        // 目的地選択
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
              alignment: const Alignment(-1.0, -1.0),
              child: Column(
                children: [
                  SizedBox(
                    child: Wrap(
                      children: [
                        for (int i = 0; i < tmpGoalName.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (goalNames[tmpGoalName[i]].isNotEmpty) {
                                      _goalisPressed = true; // ボタンが押されたかどうか
                                      _goalisColor = true; // 色を変える変数
                                      gval = i; // ボタンの名前を変える変数
                                      sendCheckedList['到着'] = true;
                                      goalName = List.from(
                                          tmpGoalName); // tmpStartNameをstartNameにコピー
                                      print('wwwwwwwww${goalName[gval!]}');
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: _goalisColor && gval == i
                                      ? const Color.fromRGBO(206, 255, 161, 1)
                                      : Colors.white,
                                  foregroundColor: Colors.black,
                                  fixedSize: const Size(115, 40),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(83, 137, 107, 1),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center, // テキストを中央に配置
                                  children: [
                                    if (gval != i)
                                      ImageIcon(
                                        AssetImage(
                                          'images/tag/${tagIcon[tmpGoalName[i]]}',
                                        ),
                                        color: Colors.black,
                                      ),
                                    // アイコンが表示される場合のみSizedBoxを追加
                                    if (gval != i) const SizedBox(width: 10),
                                    // 選択したボタンのテキストを表示
                                    Text(
                                      goalName[i],
                                      style: TextStyle(
                                        color: Colors.black,
                                        // 駅名の文字数に応じてリサイズ
                                        fontSize:
                                            (goalName[i].length > 4) ? 10 : 15,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_goalisPressed)
              Container(
                height: 120,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          // mapデータから駅名を取得
                          for (var key in goalNames[goalName[gval!]].keys)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  fixedSize: const Size(115, 40),
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
                                    _goalisPressed = false; // ボタンが押されたかどうか
                                    goalName[gval!] = key; // ボタンの名前を変える変数
                                    print('wwwwwwwww${goalName[gval!]}');
                                    if (sendCheckedList['出発'] == true &&
                                        sendCheckedList['到着'] == true) {
                                      setState(() {
                                        n = startName[sval!] +
                                            '~' +
                                            goalName[gval!];
                                      });
                                      sendCheckedList['出発'] = false;
                                    }
                                  });
                                },
                                child: Text(
                                  key,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    // 駅名の文字数に応じてリサイズ
                                    fontSize: (key.length > 4) ? 10 : 15,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
          ],
        ),

        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
