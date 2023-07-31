import 'package:cloud_firestore/cloud_firestore.dart';

class Tag {
  // snapshotのデータをMap型に変換
  Future<Map<String, dynamic>> StartNameInfo() async {
    Map<String, dynamic> data = {};

    try {
      // リスニングクエリを使用してデータを取得
        await FirebaseFirestore.instance
          .collection('guide')
          .doc('大阪府')
          .collection('大阪駅')
          .doc('出発')
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          // データが更新された場合はキャッシュを更新
            data = snapshot.data() as Map<String, dynamic>;
        }
      }).asFuture(); // リスニングクエリが完了するまで待機
      return data;
    } catch (e) {
      print('エラー：$e');
      return {};
    }
  }

  // Future<Map<String, dynamic>> StartNameInfo() async {
  //   Map<String, dynamic> data = {};
  //   try {
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('guide').doc('大阪府').collection('大阪駅').doc('出発').get();
  //     if (snapshot.exists) {
  //       data = snapshot.data() as Map<String, dynamic>;
  //     }
  //     return data;
  //   } catch (e) {
  //     print('エラー：$e');
  //     return {};
  //   }
  // }

  Future<List<String>> StartNameTitle() async {
    List<String> startNames = [];
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('guide').doc('大阪府').collection('大阪駅').doc('出発').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data.forEach((key, value) {
          startNames.add(key);
        });
      }
      return startNames;
    } catch (e) {
      print('エラー：$e');
      return [];
    }
  }

  Future<Map<String, dynamic>> GoalNames() async {
    Map<String, dynamic> data = {};
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('guide').doc('大阪府').collection('大阪駅').doc('到着').get();
      if (snapshot.exists) {
        data = snapshot.data() as Map<String, dynamic>;
      } else {
        print('ドキュメントが存在しません');
      }
      // return startNames;
      return data;
    } catch (e) {
      print('エラー：$e');
      return {};
    }
  }

  Future<List<String>> GoalName() async {
    List<String> goalNames = [];
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('guide').doc('大阪府').collection('大阪駅').doc('到着').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data.forEach((key, value) {
          goalNames.add(key);
        });
      }
      return goalNames;
    } catch (e) {
      print('エラー：$e');
      return [];
    }
  }

  Future<List<String>> methodName() async {
    List<String> methodNames = [];
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('guide').doc('大阪府').collection('大阪駅').doc('手段').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        List<dynamic> methodName = data['手段'];
        // リスト内の要素をmethodNamesリストに追加
        for (var method in methodName) {
          methodNames.add(method.toString());
        }
      }
      return methodNames;
    } catch (e) {
      print('エラー：$e');
      return [];
    }
  }

  Future<Map<String, dynamic>> TagIcon() async {
    Map<String, dynamic> tagIcon = {};
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('guide').doc('大阪府').collection('大阪駅').doc('icon').get();

      if (snapshot.exists) {
        tagIcon = snapshot.data() as Map<String, dynamic>;
        tagIcon.forEach((key, value) {
          // print('tag:$tagIcon');
        });
      } else {
        print('ドキュメントが存在しません');
      }
      // print('tag:$tagIcon');
      return tagIcon;
    } catch (e) {
      print('エラー：$e');
      return {};
    }
  }
}
