import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:go_router/go_router.dart';

class CreateTweetScreen extends StatefulWidget {
  const CreateTweetScreen({super.key});

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  int page = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  String? userProfileURl;

  Future<String?> getCurrentUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (user.photoURL != null) {
        return user.photoURL;
      } else {
        return 'https://firebasestorage.googleapis.com/v0/b/flutterfeed-5cd86.appspot.com/o/sample.jpg?alt=media&token=7e4d8841-6591-4d6d-a453-71ef692085ef';
      }
    } else {
      if (kDebugMode) {
        print('no user found');
      }
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserProfile().then((url) {
      userProfileURl = url;
    });
  }

  void onPageChange(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).go('/homescreen');
          },
          splashRadius: 20,
          icon: const Icon(Icons.close),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Pallete.blueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Post',
              style: TextStyle(
                color: Pallete.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: page,
          onTap: onPageChange,
          backgroundColor: Pallete.backgroundColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Media',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gif),
              label: 'GIF',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.poll),
              label: 'Poll',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'location',
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: userProfileURl != null
                      ? NetworkImage(userProfileURl!)
                      : const NetworkImage(
                          'assets/avatars/default_avatar.png',
                        ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'What\'s happening?',
                      border: InputBorder.none,
                    ),
                    maxLength: 280,
                    maxLines: 7,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
