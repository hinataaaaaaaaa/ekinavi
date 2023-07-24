import 'package:cloud_firestore/cloud_firestore.dart';

class Tag {
  Future<Map<String, dynamic>> StartNames() async {
    Map<String, dynamic> data = {};
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guide')
          .doc('大阪府')
          .collection('大阪駅')
          .doc('出発')
          .get();
      if (snapshot.exists) {
        data = snapshot.data() as Map<String, dynamic>;
      }
      return data;
    } catch (e) {
      print('エラー：$e');
      return {};
    }
  }

  Future<List<String>> StartName() async {
    List<String> startNames = [];
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guide')
          .doc('大阪府')
          .collection('大阪駅')
          .doc('出発')
          .get();
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
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guide')
          .doc('大阪府')
          .collection('大阪駅')
          .doc('到着')
          .get();
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
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guide')
          .doc('大阪府')
          .collection('大阪駅')
          .doc('到着')
          .get();
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

  Future<Map<String, dynamic>> TagIcon() async {
    Map<String, dynamic> tagIcon = {};
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guide')
          .doc('大阪府')
          .collection('大阪駅')
          .doc('icon')
          .get();
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
