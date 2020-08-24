import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Custom Bottom Navigation bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 10.0,
        leading: Icon(Icons.assistant),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.tealAccent,
          ),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  // Defining Page Index
  int _index = 0;
  //defining the global keys for BottomNavigation Bar Icons
  GlobalKey _menuIconKey = GlobalKey();
  GlobalKey _searchIconKey = GlobalKey();
  GlobalKey _homeIconKey = GlobalKey();
  GlobalKey _profileIconKey = GlobalKey();
  // Defining the initial Position of the tile
  Offset _tilePosition = Offset(258.0, 0.0);

  _changePosition(int index) {
    List<GlobalKey> _keyList = [
      _menuIconKey,
      _searchIconKey,
      _homeIconKey,
      _profileIconKey
    ];
    RenderBox _icon = _keyList[index].currentContext.findRenderObject();
    Offset position = _icon.localToGlobal(Offset.zero);
    _tilePosition = position;
    _index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 72.0,
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: Colors.black.withOpacity(0.6), width: 0.5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(0.1),
                height: 20.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blue.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: [0.065, 0.32, 0.85],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45.0,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
          top: 0.0,
          left: _tilePosition.dx + 0.0 - (22.5),
          /// Aboves is the finer adjustment
          /// so that you get tile excatly centered below the icon
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            width: 70.0,
            height: 56.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlue.withOpacity(0.2),
                  Colors.transparent,
                ],
                stops: [0.05, 0.05, 0.65],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            iconSize: 24.0,
            selectedIconTheme: IconThemeData(color: Colors.blueAccent,size: 30.0),
            currentIndex: _index,
            elevation: 0.0,
            onTap: (index) {
              print(index);
              _changePosition(index);
            },
            backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  key: _menuIconKey,
                ),
                title: Text(
                  'Menu',
                  style: TextStyle(
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  key: _searchIconKey,
                ),
                title: Text(
                  'Serch',
                  style: TextStyle(
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  key: _homeIconKey,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  key: _profileIconKey,
                ),
                title: Text(
                  'profile',
                  style: TextStyle(
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
