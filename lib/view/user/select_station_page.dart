import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:navi_station/view/user/main_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../admin/prefectures_inser.dart';

class SelectStation extends StatefulWidget {
  const SelectStation({super.key});

  @override
  _SelectStationState createState() => _SelectStationState();
}

class _SelectStationState extends State<SelectStation> {
  bool _showPreButton = false;
  bool _showStaButton = false;

  bool prefectures = false;
  bool station = false;

  String _selectPlace = "";
  String _selectStations = "";

  Map<String, String> tagHistory = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // 保存されている値を取得
      _selectPlace = tagHistory['pre'] = prefs.getString('pre') ?? '';
      _selectStations = tagHistory['sta'] = prefs.getString('sta') ?? '';
      prefectures = (prefs.getString('pre') ?? '').isNotEmpty;
      station = (prefs.getString('sta') ?? '').isNotEmpty;
      // prefs.remove('pre');
      // prefs.remove('sta');
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
              visible: !_showPreButton,
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
                          _selectPlace.isNotEmpty
                              ? prefectures
                                  ? _selectPlace
                                  : tagHistory['pre'] != null && tagHistory['pre']!.isNotEmpty
                                      ? tagHistory['pre']!
                                      : '都道府県を選択'
                              : '都道府県を選択',
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
                            _showPreButton = true;
                            _showStaButton = false; // 駅選択ボタンを閉じる
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
              visible: _showPreButton,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: FutureBuilder<List<Widget>>(
                  future: generateButtons1(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データが取得まち
                      return CircularProgressIndicator();
                    } else {
                      // データ取得完
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!,
                        ),
                      );
                    }
                  },
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
              visible: !_showStaButton,
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
                          _selectStations.isNotEmpty
                              ? station
                                  ? _selectStations
                                  : (station && (tagHistory['sta'] != null && tagHistory['sta']!.isNotEmpty))
                                      ? tagHistory['sta']!
                                      : '駅を選択'
                              : '駅を選択',
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
                        onPressed: prefectures
                            ? () {
                                setState(() {
                                  _showStaButton = true;
                                  _showPreButton = false; // 都道府県選択ボタンを閉じる
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
              visible: _showStaButton,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: FutureBuilder<List<Widget>>(
                  future: generateButtons2(1, _selectPlace),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データが取得まち
                      return CircularProgressIndicator();
                    } else {
                      // データ取得完
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),

            // 選択ボタン
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: station && prefectures
                    ? () async {
                        // ボタンが押されたときの処理
                        //遷移先
                        final prefs = await SharedPreferences.getInstance(); // SharedPreferencesのインスタンス
                        // Key-Valueでデータを保存
                        await prefs.setString('pre', _selectPlace);
                        await prefs.setString('sta', _selectStations);
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
  Future<List<Widget>> generateButtons1(int buttonIndex) async {
    List<String> place = [];
    List<List<String>> tmpPre = [];

    // listに都道府県を追加
    await prefecture().then((a) {
      tmpPre.addAll(a);
      for (var e in tmpPre) {
        place.add(e[1]);
      }
    });

    List<Widget> buttons = [];
    for (int i = 0; i < place.length; i++) {
      buttons.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                // 都道府県を推したときに駅を選択した状態を解除
                if (station) {
                  station = false;
                }

                _selectPlace = place[i]; // 選択した都道府県を格納
                prefectures = true; // 都道府県が選択された状態にする
                _showPreButton = false; // 都道府県選択ボタンを閉じる
              });
            },
            child: Text(place[i]),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              elevation: 10,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              //選択ボタン調整
              fixedSize: Size(
                MediaQuery.of(context).size.width * 0.2,
                MediaQuery.of(context).size.height * 0.05,
              ),
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
    //ボタン生成
    return [
      Wrap(
        children: buttons.sublist(0, place.length - 1),
      ),
    ];
  }

  // 駅選択
  Future<List<Widget>> generateButtons2(int buttonIndex, String selectPlace) async {
    List<Widget> buttons = [];

    List<String> stations = [];
    List<String> tmpSta = [];
    // updateCacheOnDataAdd(selectPlace);
    if (selectPlace.isNotEmpty) {
      await stationInfo(selectPlace).then((a) {
        tmpSta.addAll(a);
        for (var e in tmpSta) {
          stations.add(e);
        }
      });
    }

    for (int i = 0; i < stations.length; i++) {
      buttons.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                station = true; // 駅を選択した状態にする
                _selectStations = stations[i]; // 選択した駅を格納

                _showStaButton = false; // 駅選択ボタンを閉じる
              });
            },
            child: Text(stations[i]),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              elevation: 10,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              //選択ボタンサイズ調整
              fixedSize: Size(
                MediaQuery.of(context).size.width * 0.3,
                MediaQuery.of(context).size.height * 0.05,
              ),
              //選択ボタン文字サイズ調整
              textStyle: TextStyle(fontSize: (stations[i].length < 6) ? 15 : 12),
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
        children: buttons.sublist(0, stations.length),
      ),
    ];
  }

  // TODO:都道府県の情報を持ってくる(CSVファイルから)
  Future prefecture() async {
    List<List<String>> importList = await readCSVFromAssets('assets/pre.csv');
    // print(importList);
    for (var i = 0; i < importList.length; i++) {
      String prefectures = importList[i][1];
      ChatEntry chatEntry = ChatEntry(prefectures);
    }
    return importList;
  }

  // TODO：駅名の取得：キャッシュから取得(分けるべき)
  Future<List<String>> stationInfo(String selectPlace) async {
    CollectionReference guideCollection = FirebaseFirestore.instance.collection('guide');
    List<String> stationList = [];

    // キャッシュの使用を明示的に指定
    final QuerySnapshot querySnapshot = await guideCollection.doc(selectPlace).collection('駅名').get(GetOptions(source: Source.cache)); // キャッシュから読み取る

    if (querySnapshot.size > 0) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        String documentName = documentSnapshot.id;
        stationList.add(documentName);
        print('Document Name: $documentName');
      }
    } else {
      print('No documents found in the subcollection. Fetching from remote...');

      // キャッシュにデータがない場合、リモートからデータを取得
      final QuerySnapshot remoteSnapshot = await guideCollection.doc(selectPlace).collection('駅名').get(GetOptions(source: Source.server)); // リモートから読み取る

      if (remoteSnapshot.size > 0) {
        for (QueryDocumentSnapshot documentSnapshot in remoteSnapshot.docs) {
          String documentName = documentSnapshot.id;
          stationList.clear(); // 駅名を格納するリストをクリア
          stationList.add(documentName);
          print('Remote Document Name: $documentName');
        }
      } else {
        print('No documents found remotely.');
      }
    }
    return stationList;
  }

// TODO：キャッシュ更新用(分けるべき)
  void updateCacheOnDataAdd(String selectPlace) async {
    CollectionReference guideCollection = FirebaseFirestore.instance.collection('guide');

    // リモートからデータを取得
    final QuerySnapshot remoteSnapshot = await guideCollection.doc(selectPlace).collection('駅名').get(GetOptions(source: Source.server));

    if (remoteSnapshot.size > 0) {
      // 取得したデータをキャッシュに追加する
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      for (QueryDocumentSnapshot documentSnapshot in remoteSnapshot.docs) {
        DocumentReference cachedDocRef = guideCollection.doc(selectPlace).collection('駅名').doc(documentSnapshot.id);
        batch.set(cachedDocRef, documentSnapshot.data());
      }
      // バッチでキャッシュを更新
      await batch.commit();
      print('Cache updated with new data.');
    } else {
      print('No new data to update cache.');
    }
  }
}
