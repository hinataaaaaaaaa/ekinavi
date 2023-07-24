import 'package:cloud_firestore/cloud_firestore.dart';

class stationInfoAdd {
  void busInfoAdd() async {
    try {
      // Firestore インスタンスの取得
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // DocumentReference を作成
      DocumentReference preDocRef =
          firestore.collection('guide').doc('大阪府').collection('大阪駅').doc('到着');

      DocumentSnapshot snapshot = await preDocRef.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

// バス停フィールドの現在の値を取得
      Map<String, dynamic> busStopMap = data['出口'] ?? {};

// 新しい駅名のマップを追加
      busStopMap['東出口'] = {'階層': '1'};

// バス停フィールドを更新
      await preDocRef.update({'出口': busStopMap});
    } catch (e) {
      print('エラー：$e');
    }
  }
}
