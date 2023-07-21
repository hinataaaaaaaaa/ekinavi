import 'package:flutter/material.dart';

class videoSelect extends StatelessWidget {
  const videoSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 280,
            width: 360,
            margin: EdgeInsets.only(bottom: 5),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.5),
                borderRadius: BorderRadius.circular(20), // 角丸
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  'https://www.kiddyland.co.jp/wp-content/uploads/osaka_jr01.jpg', // 動画サムネ
                  height: 196,
                  width: 330,
                ),
                Container(
                  margin: EdgeInsets.only(left: 100, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('images/tag/start.png'),
                      Image.asset('images/tag/goal.png'),
                      ElevatedButton(
                        onPressed: () {/* ボタンが押時(動画選択) */},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromRGBO(255, 248, 250, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                        ),
                        child: Text('動画を選択'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {/* ボタンが押時(投稿) */},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Color.fromRGBO(201, 255, 182, 1),
              fixedSize: Size(120, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
            ),
            child: Text(
              'アップロード',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
