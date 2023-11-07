import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterfeed/models/tweet_type.dart';

@immutable
class Tweet {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  final String retweetedBy;
  final String repliedTo;

  Tweet({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
    required this.retweetedBy,
    required this.repliedTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'hashtags': hashtags,
      'link': link,
      'imageLinks': imageLinks,
      'uid': uid,
      'tweetType': tweetType.type,
      'tweetedAt': tweetedAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'id': id,
      'reshareCount': reshareCount,
      'retweetedBy': retweetedBy,
      'repliedTo': repliedTo,
    };
  }

  final CollectionReference tweetsCollection =
      FirebaseFirestore.instance.collection('tweets');

  Future<void> createTweet() async {
    try {
      await tweetsCollection.add(toMap());
    } catch (e) {
      print('Error creating tweet: $e');
    }
  }
}

// Usage example
void main() async {
  Tweet myTweet = Tweet(
    text: 'This is my tweet!',
    hashtags: const ['flutter', 'example'],
    link: ' ',
    imageLinks: const [''],
    uid: 'user123',
    tweetType: TweetType.text,
    tweetedAt: DateTime.now(),
    likes: const [],
    commentIds: const [],
    id: 'tweet123',
    reshareCount: 0,
    retweetedBy: '',
    repliedTo: '',
  );

  // Call createTweet to add the tweet to Firestore
  await myTweet.createTweet();
}
