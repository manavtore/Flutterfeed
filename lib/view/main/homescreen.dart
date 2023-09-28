import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfeed/common/Reusables/appbar.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:go_router/go_router.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int page = 0;

  void onPageChange(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIcomponenets.appBar,
      body: const IndexedStack(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go('/createTweet');
        },
        backgroundColor: Pallete.blueColor,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
