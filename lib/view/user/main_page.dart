import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'components/user_tag.dart';
import '../../main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

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
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50),
        child:AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            // 表示アイコン
            icon: Icon(Icons.arrow_back),
            color: Color.fromRGBO(83, 137, 107, 1),
            // サイズ
            iconSize: 40,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              icon: Icon(Icons.help),
              color: Color.fromRGBO(83, 137, 107, 1),
              iconSize: 40,
            ),
          ],
          backgroundColor: Color.fromRGBO(201, 255, 182, 1.0),
          // backgroundColor: Colors.white,
          elevation: 2,
          // title: Text(widget.title!),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 255, 245),
        body:
          TabBarView(
            physics:
              NeverScrollableScrollPhysics(), 
            controller: _tabController,
            children: <Widget>[
              Center(child: 
              Column(
                children: [
                  UserTagWidget(),
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: 410,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        child:Row( 
                          children: [
                            SizedBox(
                              width: 3, 
                            ),
                            Icon(
                              Icons.video_library, 
                              size: 30,
                              color: Colors.black, 
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '動画',
                              style: TextStyle(fontSize: 20 , fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        color: Color.fromRGBO(201, 255, 182, 1),
                      ),
                    ],
                  ),
                //TODO:動画追加
                ],
              ),
            ),
            const Center(child: MyApp()),
          ],
        ), 


        bottomNavigationBar: MotionTabBar(
          initialSelectedTab: "Home",
          useSafeArea: true,
          labels: const ["Home", "Map"],
          icons: const [
            Icons.home,
            Icons.map,
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
            }
          );
        },
      ),
    );
  }
}
