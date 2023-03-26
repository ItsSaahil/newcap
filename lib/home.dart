import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newcap/Account.dart';
import 'package:newcap/Detail.dart';
import 'package:newcap/Doctor_info.dart';
import 'package:newcap/Prediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
//<<<<<<< HEAD
  List<Widget> _lis = [
    const Detail(),
    const Doctor_info(),
    Predict(),
    Account()
  ];
//=======
  final List<Widget> _pages = [
    const Detail(),
    const Doctor_info(),
    Predict(),
    Account()
  ];
//>>>>>>> 7a508865a3c72049d58b6b64c77897921ddd502d
  var primary = const Color.fromARGB(255, 227, 14, 53);
  int _currentIndex = 0;
  final PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: _pages),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Home'),
                icon: const Icon(Icons.home)),
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Doctor'),
                icon: const Icon(Icons.medical_services_rounded)),
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Predection'),
                icon: const Icon(Icons.event_note_rounded)),
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Account'),
                icon: const Icon(Icons.manage_accounts_rounded)),
          ],
        ),
      ),
    );
  }
}
