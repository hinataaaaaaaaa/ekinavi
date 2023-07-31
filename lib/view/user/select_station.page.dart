import 'package:flutter/material.dart';
import 'package:navi_station/view/user/main_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SelectStation extends StatefulWidget {
  const SelectStation({super.key});

  @override
  _SelectStationState createState() => _SelectStationState();
}

class _SelectStationState extends State<SelectStation> {
  bool _showButtons1 = false;
  bool _showButtons2 = false;

  bool todohuken = false;
  bool station = false;

  int _selectedButton1 = 0;
  int _selectedButton2 = 0;

  String _selectPlace = "";
  String _selectStations = "";

  String pre = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectPlace = pre = prefs.getString('pre') ?? '';
      // prefs.remove('pre');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 254, 224, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Text(
              '都道府県',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Visibility(
              visible: !_showButtons1,
              child: Column(
                children: [
                  Align(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: ElevatedButton.icon(
                        icon: ImageIcon(
                          AssetImage('images/tag/japan.png'),
                          size: 50,
                        ),
                        label: Text(
                          _selectedButton1 == 0
                              ? pre.isNotEmpty
                                  ? pre
                                  : '都道府県を選択'
                              : _selectPlace,
                          style: TextStyle(
                            fontSize: _selectPlace.isNotEmpty ? 25 : 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.5,
                            MediaQuery.of(context).size.height * 0.1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _showButtons1 = true;
                            _showButtons2 = false; // 駅選択ボタンを閉じる
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Visibility(
              visible: _showButtons1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: generateButtons1(1),
                  ),
                ),
              ),
            ),

            // 駅選択ボタン
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),

            Text(
              '駅',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            Visibility(
              visible: !_showButtons2,
              child: Column(
                children: [
                  Align(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
                      child: ElevatedButton.icon(
                        icon: ImageIcon(
                          AssetImage('images/tag/train.png'),
                          size: 50,
                        ),
                        label: Text(
                          _selectedButton2 == 0 ? '駅を選択' : _selectStations,
                          style: TextStyle(
                            fontSize: _selectPlace.isNotEmpty ? 25 : 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.5,
                            MediaQuery.of(context).size.height * 0.1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(83, 137, 107, 1),
                          ),
                        ),
                        onPressed: todohuken
                            ? () {
                                setState(() {
                                  _showButtons2 = true;
                                  _showButtons1 = false; // 都道府県選択ボタンを閉じる
                                });
                              }
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Visibility(
              visible: _showButtons2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: generateButtons2(1),
                  ),
                ),
              ),
            ),

            // 選択ボタン
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: station && _selectedButton2 != 0
                    ? () async {
                        // ボタンが押されたときの処理
                        //遷移先
                        final prefs = await SharedPreferences.getInstance(); // SharedPreferencesのインスタンス
                        // Key-Valueでデータを保存
                        await prefs.setString('pre', _selectPlace);
                        pre = prefs.getString('pre')!;
                        // await stations.setString('sta', _selectStations);
                        print('完了:$pre'); // TODO : ここでデータを保存する
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserPage(root: '')),
                        );
                      }
                    : null,
                child: Text('選択'),
                // child: Text('登録'),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: const Color.fromRGBO(206, 255, 189, 1),
                  foregroundColor: Colors.black,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.5,
                    MediaQuery.of(context).size.height * 0.08,
                  ),
                  textStyle: TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    width: 2,
                    color: Color.fromRGBO(83, 137, 107, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 都道府県選択
  List<Widget> generateButtons1(int buttonIndex) {
    List<String> place = ["", "大阪府", "東京都", "京都府", "神奈川県", "兵庫県", "愛知県", "愛知県", "北海道", "福岡県"];

    List<Widget> buttons = [];
    for (int i = 1; i < place.length; i++) {
      buttons.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                // 駅を選んだ後に都道府県に戻るときの処理
                if (station) {
                  _selectedButton2 = 0;
                }

                _selectedButton1 = i;
                _selectPlace = place[i];
                todohuken = true;

                if (buttonIndex == 1) {
                  _showButtons1 = false;
                } else if (buttonIndex == 2) {
                  _showButtons2 = false;
                }
                // ボタンが押されたときの処理
              });
            },
            child: Text(place[i]),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              //選択ボタン調整
              fixedSize: Size(80, 40),
              //選択ボタンの文字サイズ
              textStyle: TextStyle(fontSize: (place[i].length < 4) ? 15 : 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              side: const BorderSide(
                width: 2,
                color: Color.fromRGBO(83, 137, 107, 1),
              ),
            ),
          ),
        ),
      );
    }
    //ボタン生成列調整
    return [
      Wrap(
        children: buttons.sublist(0, place.length - 1),
      ),
      Wrap(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: buttons.sublist(0, 5),
      ),
      Wrap(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: buttons.sublist(4, 8),
      ),
    ];
  }

  // 駅選択
  List<Widget> generateButtons2(int buttonIndex) {
    List<Widget> buttons = [];
    List<String> stations = [
      "",
      "大阪駅",
      "梅田駅",
      "新大阪駅",
      "難波駅",
      "天王寺駅",
      "心斎橋駅",
    ];
    for (int i = 1; i < stations.length; i++) {
      buttons.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedButton2 = i;
                _selectStations = stations[i];
                station = true;

                if (buttonIndex == 1) {
                  _showButtons2 = false;
                } else if (buttonIndex == 2) {
                  _showButtons2 = false;
                }
                // ボタンが押されたときの処理
              });
            },
            child: Text(stations[i]),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              //選択ボタンサイズ調整
              fixedSize: Size(80, 40),
              //選択ボタン文字サイズ調整
              textStyle: TextStyle(fontSize: (stations[i].length < 4) ? 15 : 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              side: const BorderSide(
                width: 2,
                color: Color.fromRGBO(83, 137, 107, 1),
              ),
            ),
          ),
        ),
      );
    }
    //ボタンの生成列
    return [
      Wrap(
        children: buttons.sublist(0, stations.length - 1),
      ),
      Wrap(
        children: buttons.sublist(0, stations.length - 1),
      ),
      Wrap(
        children: buttons.sublist(0, stations.length - 1),
      ),
    ];
  }
}
