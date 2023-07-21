import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:navi_station/view/admin/login.dart';
import 'package:navi_station/view/admin/videoSelect.dart';
import 'package:navi_station/main.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          // 表示アイコン
          icon: Image.asset('images/tag/return.png'),
          // サイズ
          iconSize: 46,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            icon: Image.asset('images/tag/help.png'),
          ),
        ],
        // backgroundColor: Color.fromRGBO(248, 255, 245, 1),
        backgroundColor: Colors.white,
        elevation: 0,
        // title: Text(widget.title!),
      ),
      body: TabBarView(
        physics:
            NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Center(child: Text("Home")),
          const Center(child: videoSelect()),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Home", "Upload"],
        icons: const [
          Icons.home,
          Icons.upload,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Color.fromRGBO(173, 173, 173, 1),
        tabIconSize: 50.0,
        tabIconSelectedSize: 40.0,
        tabSelectedColor: Color.fromRGBO(129, 191, 107, 1),
        tabIconSelectedColor: Colors.white,
        tabBarColor: const Color.fromRGBO(201, 255, 182, 1.0),
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
    );
  }
}
