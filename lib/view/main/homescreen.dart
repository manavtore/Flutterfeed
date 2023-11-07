import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfeed/common/assets/Reusables/appbar.dart';
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tweets').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var tweets = snapshot.data!.docs;
          return ListView.builder(
              itemCount: tweets.length,
              itemBuilder: (context, index) {
                var tweet = tweets[index].data();

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                      leading: const SizedBox(
                        width: 45,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/flutterfeed-5cd86.appspot.com/o/Profilepic%2Fdilvich.jpeg?alt=media&token=1b4d39f5-d56f-4758-b9d0-04f91912a121&_gl=1*1igpife*_ga*MTQ3NDc1NTA0NS4xNjkzOTc4MDU3*_ga_CW55HF8NVT*MTY5NzYzNDE0MC40Ny4xLjE2OTc2MzY5NTguNTQuMC4w'),
                        ),
                      ),
                      title: Text(
                        tweet['name'] ?? 'Username',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tweet['text']),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 250,
                              child: Image.network(
                                tweet['imageUrl']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.comment),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.repeat),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.favorite),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              });
        },
      ),
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
