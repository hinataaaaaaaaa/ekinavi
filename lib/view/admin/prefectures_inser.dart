import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

Future<List<List<String>>> readCSVFromAssets(String path) async {
  String csvString = await rootBundle.loadString(path);
  List<List<String>> csvData = [];
  csvString.split('\n').forEach((row) {
    csvData.add(row.split(','));
  });
  return csvData;
}

Future prefecture() async {
  try {
    List<List<String>> importList = await readCSVFromAssets('assets/pre.csv');

    for (var i = 0; i < importList.length; i++) {
      String prefectures = importList[i][1];
      ChatEntry chatEntry = ChatEntry(prefectures);
      await FirebaseFirestore.instance
          .collection('guide')
          .doc(prefectures)
          .set({});
    }
  } catch (e) {
    print('Error reading file: $e');
  }
  print('added');
}

class ChatEntry {
  String prefectures; // 都道府県

  ChatEntry(this.prefectures);

  ChatEntry.fromSnapshot(DataSnapshot snapshot)
      : prefectures = (snapshot.value as Map<String, dynamic>)["prefectures"];

  dynamic toJson() {
    return prefectures;
  }
}

Future station() async {

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
      });
    } else {
      print('ドキュメントが存在しません');
    }
  } catch (e) {
    print('エラー：$e');
  }
}
