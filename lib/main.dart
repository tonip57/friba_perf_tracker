import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/settings.dart';
import 'package:friba_performance_tracker/statistics.dart';
import 'package:friba_performance_tracker/rounds.dart';
import 'package:flutter/services.dart';

// Starts the app.
void main() {
// Disables landscape mode.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Handles the change of screen when tapping nav bar items.
  void _onItemTapped(int index) {
    //print(index);

    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  /// Builds the initial widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [Statistics(), Rounds(), Settings()],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart), label: "Stats"),
            BottomNavigationBarItem(
                icon: Icon(Icons.golf_course), label: "Rounds"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[600],
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
