import 'package:cloud_firestore/cloud_firestore.dart';

class stationAdd {
  Future selectStationAdd() async {
    // Firestore インスタンスの取得
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // "guide" コレクションの中の既存のドキュメントを参照
    DocumentReference preDocRef = firestore.collection('guide').doc('大阪府');

    // コレクションのドキュメントにデータを追加
    await preDocRef.collection('大阪駅').doc('出発').set({
      'バス停': {},
      '出口': {},
      '改札': {},
    });

    await preDocRef.collection('大阪駅').doc('到着').set({
      'バス停': {},
      '出口': {},
      '改札': {},
    });

    await preDocRef.collection('大阪駅').doc('手段').set({
      '手段': ['徒歩', 'エレベーター'],
    });

// TODO : icon
    // await preDocRef.collection('大阪駅').doc('手段').set({
    //   '手段': ['徒歩', 'エレベーター'],
    // });
  }
}
