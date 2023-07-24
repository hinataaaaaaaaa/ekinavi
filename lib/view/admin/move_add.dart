import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:navi_station/view/admin/get_data.dart';

Future MoveAdd(String start, String end, String method, String videoTitle,
    String videoPath) async {
  Data data = Data();
  List<dynamic> dateTimeValues = data.getFormattedDateTime();
  
  final storageRef = FirebaseStorage.instance.ref();

  final stationsRef = storageRef.child('guide/大阪府/大阪駅');

  String? stationId = '$start~$end';

  await stationsRef
      .child('$stationId/$method.MOV')
      .putFile(File(videoPath));

  print('追加済み'); // 確認用

}
