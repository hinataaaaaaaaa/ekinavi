import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:navi_station/main.dart';
import 'package:navi_station/view/user/tag_show_logic.dart';

import '../../config/color_config.dart';
import '../admin/show_move.dart';

class UserPage extends StatefulWidget {
  final String root;
  const UserPage({super.key, required this.root});

  @override
  State<UserPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserPage> with TickerProviderStateMixin {
  //ボタンが押されたかどうか
  bool _startIsPressed = false;
  bool _goalIsPressed = false;

  // 色を変える変数
  bool _startIsColor = false;
  bool _goalIsColor = false;
  bool _methodsColor = false;
  // ボタンの名前を変える変数
  int? sval;
  int? gval;
  int? mval;

  // ボタンの名前の配列
  Tag tags = Tag();
  Map<String, dynamic> startNames = {}; // 出発地点の詳細を格納
  List<String> startName = []; // 出発地点を格納
  List<String> tmpStartName = []; // 一時的なリストを作成

  Map<String, dynamic> goalNames = {}; // 到着地点の詳細を格納
  List<String> goalName = []; // 到着地点を格納
  List<String> tmpGoalName = []; // 一時的なリストを作成

  List<String> methodNames = []; // 手段の詳細を格納

  Map<String, bool> sendCheckedList = {'出発': false, '到着': false, '手段': false}; // 送信確認用のリスト

  Map<String, dynamic> tagIcon = {}; // アイコンのパスを格納

  String? routeName;
  String? method;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _fetchStartNames(); // 出発地点の名前を取得
    _fetchStartInfo(); // 出発地点の詳細を取得
    _fetchGoalNames(); // 出発地点の名前を取得
    _fetchGoalInfo(); // 出発地点の詳細を取得
    _fetchMethodNames(); // 手段の詳細を取得
    _fetchTagIcon(); // アイコンのパスを取得
    _tabController = TabController(
      initialIndex: 0,
      length: 1,
      vsync: this,
    );
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

// 手段の詳細を取得
  Future<void> _fetchMethodNames() async {
    List<String> names = await tags.methodName();
    setState(() {
      methodNames = names;
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
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
            // 表示アイコン
            icon: ImageIcon(
              AssetImage('images/tag/return.png'),
              color: ColorConfig.darkGreen,
            ),
            iconSize: 40,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              icon: const ImageIcon(
                AssetImage('images/tag/help.png'),
                color: Colors.black,
              ),
              iconSize: 40,
            )
          ],
          backgroundColor: ColorConfig.mainColor,
          elevation: 2,
        ),
      ),
      body: RefreshIndicator(
        // リロード用に設定
        onRefresh: () async {
          await _fetchStartNames();
          await _fetchGoalNames();
          await _fetchMethodNames();
          // 初期値に戻す
          _startIsColor = false;
          _goalIsColor = false;
          _methodsColor = false;
          sval = null;
          gval = null;
          mval = null;
          sendCheckedList = sendCheckedList.map(((key, value) => MapEntry(key, false)));
          // print(sendCheckedList);
          // Navigator.popUntil(context, (route) => route.isFirst);// スタックに積まれた画面を破棄
        },
        // スクロール可
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
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
                          width: double.infinity,
                          height: 120,
                          alignment: const Alignment(-1.0, -1.0),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: <Widget>[
                                      // dbから取得したデータを表示
                                      for (int i = 0; i < tmpStartName.length; i++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (startNames[tmpStartName[i]].isNotEmpty) {
                                                  _startIsPressed = true; // ボタンが押されたかどうか
                                                  _startIsColor = true; // 色を変える変数
                                                  sval = i; // ボタンの名前を変える変数
                                                  startName = List.from(tmpStartName); // 元の項目を表示するために元のリストをコピー
                                                }
                                              });
                                            },
                                            // ボタンのスタイル設定
                                            style: ElevatedButton.styleFrom(
                                              elevation: 10,
                                              backgroundColor:
                                                  // ボタンの色を変える
                                                  _startIsColor && sval == i ? ColorConfig.tagColor : Colors.white,
                                              foregroundColor: Colors.black,
                                              fixedSize: Size(MediaQuery.of(context).size.width * 0.29, _size.height * 0.05),
                                              side: BorderSide(
                                                width: 2,
                                                color: ColorConfig.darkGreen,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center, // テキストを中央に配置
                                              children: [
                                                // 選択していないボタンのアイコンを表示
                                                if (sval != i)
                                                  ImageIcon(
                                                    AssetImage(
                                                      'images/tag/${tagIcon[tmpStartName[i]]}',
                                                    ), // アイコンのパスを指定
                                                    color: Colors.black, // アイコンの色を指定
                                                  ),
                                                if (sval != i) const SizedBox(width: 10), // アイコンが表示される場合のみSizedBoxを追加
                                                // 選択したボタンのテキストを表示
                                                Text(
                                                  startName[i],
                                                  textScaleFactor: (startName[i].length > 6) ? 0.6 : 1, // 文字数に応じてリサイズ
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ボタンが押されたときに表示される
                        if (_startIsPressed)
                          Container(
                            height: 120,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      children: <Widget>[
                                        // mapデータから駅名を取得
                                        for (var key in startNames[startName[sval!]].keys)
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                            // ボタンのスタイル設定
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                fixedSize: Size(MediaQuery.of(context).size.width * 0.29, _size.height * 0.05),
                                                side: BorderSide(
                                                  width: 2,
                                                  color: ColorConfig.darkGreen,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  // ボタンが押されたかどうか
                                                  sendCheckedList['出発'] = true;
                                                  _startIsPressed = false; // ボタンが押されたかどうか
                                                  startName[sval!] = key; // ボタンの名前を変える変数
                                                  if (sendCheckedList['出発'] == true && sendCheckedList['到着'] == true && sendCheckedList['手段'] == true) {
                                                    // タグ変更時に送るデータの設定用
                                                    setState(() {
                                                      routeName = '${startName[sval!]}~${goalName[gval!]}';
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text(
                                                key,
                                                textScaleFactor: (key.length > 6) ? 0.6 : 1, // 文字数に応じてリサイズ
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                      ],
                    ),
                    // 到着地点選択
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
                    const SizedBox(height: 5),
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          alignment: const Alignment(-1.0, -1.0),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                  child: Wrap(
                                    // alignment: WrapAlignment.start,
                                    children: <Widget>[
                                      // dbから取得したデータを表示
                                      for (int i = 0; i < tmpGoalName.length; i++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (goalNames[tmpGoalName[i]].isNotEmpty) {
                                                    _goalIsPressed = true; // ボタンが押されたかどうか
                                                    _goalIsColor = true; // 色を変える変数
                                                    gval = i; // ボタンの名前を変える変数
                                                    sendCheckedList['到着'] = true;
                                                    goalName = List.from(tmpGoalName); // 元の項目を表示するために元のリストをコピー
                                                  }
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                backgroundColor: _goalIsColor && gval == i ? ColorConfig.tagColor : Colors.white,
                                                foregroundColor: Colors.black,
                                                fixedSize: Size(MediaQuery.of(context).size.width * 0.29, _size.height * 0.05),
                                                side: BorderSide(
                                                  width: 2,
                                                  color: ColorConfig.darkGreen,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center, // テキストを中央に配置
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
                                                    textScaleFactor: (goalName[i].length > 6) ? 0.6 : 1, // 文字数に応じてリサイズ
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_goalIsPressed)
                          Container(
                            height: 120,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                    child: Wrap(
                                      children: [
                                        // mapデータから駅名を取得
                                        for (var key in goalNames[goalName[gval!]].keys)
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                fixedSize: Size(MediaQuery.of(context).size.width * 0.29, _size.height * 0.05),
                                                side: BorderSide(
                                                  width: 2,
                                                  color: ColorConfig.darkGreen,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _goalIsPressed = false; // ボタンが押されたかどうか
                                                  goalName[gval!] = key; // ボタンの名前を変える変数
                                                  if (sendCheckedList['出発'] == true && sendCheckedList['到着'] == true && sendCheckedList['手段'] == true) {
                                                    // タグ変更時に送るデータの設定用
                                                    setState(() {
                                                      routeName = '${startName[sval!]}~${goalName[gval!]}';
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text(
                                                key,
                                                textScaleFactor: (key.length > 6) ? 0.6 : 1, // 文字数に応じてリサイズ
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                      ],
                    ),
                    // 手段選択
                    const Row(
                      children: [
                        ImageIcon(
                          AssetImage('images/tag/toilet.png'),
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
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          alignment: const Alignment(-1.0, -1.0),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                  child: Wrap(
                                    children: [
                                      for (int i = 0; i < methodNames.length; i++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (methodNames[i].isNotEmpty) {
                                                    _methodsColor = true; // 色を変える変数
                                                    mval = i; // ボタンの名前を変える変数
                                                    sendCheckedList['手段'] = true;
                                                    if (sendCheckedList['出発'] == true && sendCheckedList['到着'] == true && sendCheckedList['手段'] == true) {
                                                      // タグ変更時に送るデータの設定用
                                                      setState(() {
                                                        routeName = '${startName[sval!]}~${goalName[gval!]}';
                                                        method = methodNames[i];
                                                      });
                                                    }
                                                  }
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                backgroundColor: _methodsColor && mval == i ? ColorConfig.tagColor : Colors.white,
                                                foregroundColor: const Color.fromARGB(255, 249, 248, 248),
                                                fixedSize: Size(MediaQuery.of(context).size.width * 0.29, _size.height * 0.05),
                                                side: BorderSide(
                                                  width: 2,
                                                  color: ColorConfig.darkGreen,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center, // テキストを中央に配置
                                                children: [
                                                  if (mval != i)
                                                    ImageIcon(
                                                      AssetImage(
                                                        'images/tag/${tagIcon[methodNames[i]]}',
                                                      ),
                                                      color: Colors.black,
                                                    ),
                                                  const SizedBox(width: 5),
                                                  // 選択したボタンのテキストを表示
                                                  Text(
                                                    methodNames[i],
                                                    textScaleFactor: (methodNames[i].length > 4) ? 0.6 : 1, // 文字数に応じてリサイズ
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )),
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
                    const SizedBox(height: 20),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 35,
                        alignment: Alignment.centerLeft,
                        color: ColorConfig.mainColor,
                        child: const Row(
                          children: [
                            SizedBox(width: 3),
                            Icon(
                              Icons.video_library,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '動画',
                              style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: Container(
                      // TODO : 仮置き中
                      // 動画の表示
                      child: (routeName == null)
                      // child: (routeName != null)
                          // ? Text('動画を表示') 
                          ? ShowMove(
                              routeKey: '${routeName}_$routeName',
                              methodKey: '${method}_$method',
                              routeName: routeName,
                              method: method,
                            )
                          // 未選択時の表示
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (!sendCheckedList['出発']!)
                                      const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          '出発',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    if (!sendCheckedList['到着']!)
                                      const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          '到着',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, // テキストの太さ
                                            fontSize: 16, // テキストのサイズ
                                            color: Colors.red, // テキストの色
                                          ),
                                        ),
                                      ),
                                    if (!sendCheckedList['手段']!)
                                      const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          '手段',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    const Text('を選択してください'),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const ["Home", "google map"],
        icons: const [
          Icons.home,
          Icons.map,
        ],
        tabSize: 50,
        tabBarHeight: 48,
        textStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.grey,
        tabIconSize: 50.0,
        tabIconSelectedSize: 40.0,
        tabSelectedColor: const Color.fromRGBO(129, 191, 107, 1),
        tabIconSelectedColor: Colors.white,
        tabBarColor: ColorConfig.mainColor,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
    );
  }
}
