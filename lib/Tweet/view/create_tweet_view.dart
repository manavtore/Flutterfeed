// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfeed/theme/pallete.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateTweetScreen extends StatefulWidget {
  const CreateTweetScreen({Key? key}) : super(key: key);

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  TextEditingController tweetController = TextEditingController();
  int page = 0;
  String? userProfileURl;
  File? _imagefile;
  String? downloadURL;

  Future<String?> getCurrentUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (user.photoURL != null) {
        return user.photoURL;
      } else {
        return 'assets/avatars/default_avatar.png';
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
      setState(() {
        userProfileURl = url;
      });
    });
  }

  void onPageChange(int index) {
    setState(() {
      page = index;
    });
  }

  Future<void> getImage() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (kDebugMode) {
      print('${file?.path}');
    }
    if (file != null) {
      setState(() {
        _imagefile = File(file.path);
      });
    }
  }

  Future<String> uploadImageToStorage() async {
    if (_imagefile == null) {
      return '';
    }
    String filename = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceroot = FirebaseStorage.instance.ref();

    Reference referenceDirImages = referenceroot.child('Images');

    Reference referenceToUploadImage = referenceDirImages.child(filename);

    try {
      await referenceToUploadImage.putFile(_imagefile!);
      downloadURL = await referenceToUploadImage.getDownloadURL();
      if (kDebugMode) {
        print(downloadURL);
      }
      return downloadURL!;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
    }
  }

  Widget _buildImagePreview() {
    if (_imagefile != null) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Image.file(_imagefile!),
      );
    } else {
      return Container();
    }
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
            onPressed: () => createTweet('WJ8VNkFsHsdxVNbxdDNU13Mmho53'),
            style: TextButton.styleFrom(
              backgroundColor: Pallete.blueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(child: Icon(Icons.image), onTap: getImage),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(child: Icon(Icons.gif), onTap: getImage),
            label: 'GIF',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(child: Icon(Icons.poll), onTap: getImage),
            label: 'Poll',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                child: Icon(Icons.location_on), onTap: getImage),
            label: 'location',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   radius: 25,
                //   backgroundImage: userProfileURl != null
                //       ? NetworkImage(userProfileURl!)
                //       : const NetworkImage(
                //           'assets/avatars/default_avatar.png',
                //         ),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: tweetController,
                    decoration: const InputDecoration(
                      hintText: 'What\'s happening?',
                      border: InputBorder.none,
                    ),
                    maxLength: 280,
                    maxLines: 7,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            _buildImagePreview(),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createTweet(String uid) async {
    if (_imagefile != null) {
      downloadURL = await uploadImageToStorage();
    }

    Map<String, dynamic> tweet = {
      'text': tweetController.text,
      'uid': uid,
      'tweetType': 'text',
      'tweetedAt': FieldValue.serverTimestamp(),
      'likes': [],
      'commentIds': [],
      'reshareCount': 0,
      'retweetedBy': '',
      'repliedTo': '',
      'imageUrl': downloadURL,
    };

    try {
      await FirebaseFirestore.instance.collection('tweets').add(tweet);
      GoRouter.of(context).go('/homescreen');
    } catch (e) {
      if (kDebugMode) {
        print('Error creating tweet: $e');
      }
    }
  }
}
