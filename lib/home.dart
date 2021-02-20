
import 'package:clone_app/pageview/chat.dart';
import 'package:flutter/material.dart';

import 'pageview/chat.dart';

/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Home(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Home>
{
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>
  [
    ChatList(),
    Text(
      'Call Logs',
        style: TextStyle(color: Colors.white)
    ),
    Text(
      'Contacts',
        style: TextStyle(color: Colors.white)
    ),
  ];

  void _onItemTapped(int index)
  {
    setState(()
    {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(child: Icon(Icons.edit), onPressed: (){},),
      backgroundColor: Colors.white10,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Contacts"
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
      //  backgroundColor: Color(0xFF1c1c1b),
        backgroundColor: Colors.white10,

        onTap: _onItemTapped,
      ),
    );
  }
}

