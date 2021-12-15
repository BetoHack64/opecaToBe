import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:motion_tab_bar/MotionTabBarView.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:motion_tab_bar/MotionTabController.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:motion_tab_bar/motiontabbar.dart';

void main() => runApp(Aprovacoes());

class Aprovacoes extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        bottomNavigationBar: MotionTabBar(
          labels: ["Aprovar", "Rejeitar"],
          initialSelectedTab: "Dashboard",
          tabIconColor: Colors.red,
          tabSelectedColor: (_tabController.index == 1) ? Colors.green : Colors.blue,
          onTabItemSelected: (int value) {
            //print(value);
            setState(() {
              _tabController.index = value;
              
            });
          },
          icons: [Icons.account_box, Icons.home, Icons.cancel_outlined],
          textStyle: TextStyle(color: Colors.red),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                child: Text("Account"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Home"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Dashboard"),
              ),
            ),
          ],
        ));
  }
}
