// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:flutter/foundation.dart';

class Usermodel {
  final String email;
  final String name;
  final List<String> followers;
  final List<String> following;
  final String profilePic;
  final String bannerPic;
  final String bio;
  final String uid;
  final bool isverified;

  const Usermodel({
    required this.email,
    required this.name,
    required this.followers,
    required this.following,
    required this.profilePic,
    required this.bannerPic,
    required this.bio,
    required this.uid,
    required this.isverified,
  });

  Usermodel copyWith({
    String? email,
    String? name,
    List<String>? followers,
    List<String>? following,
    String? profilePic,
    String? bannerPic,
    String? bio,
    String? uid,
    bool? isverified,
  }) {
    return Usermodel(
      email: email ?? this.email,
      name: name ?? this.name,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      profilePic: profilePic ?? this.profilePic,
      bannerPic: bannerPic ?? this.bannerPic,
      bio: bio ?? this.bio,
      uid: uid ?? this.uid,
      isverified: isverified ?? this.isverified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'followers': followers,
      'following': following,
      'profilePic': profilePic,
      'bannerPic': bannerPic,
      'bio': bio,
      'uid': uid,
      'isverified': isverified,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      email: map['email'] as String,
      name: map['name'] as String,
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      profilePic: map['profilePic'] as String,
      bannerPic: map['bannerPic'] ?? '',
      bio: map['bio'] ?? '',
      uid: map['uid'] as String,
      isverified: map['isverified'] as bool,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Usermodel.fromJson(String source) => Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Usermodel(email: $email, name: $name, followers: $followers, following: $following, profilePic: $profilePic, bannerPic: $bannerPic, bio: $bio, uid: $uid, isverified: $isverified)';
  // }

  @override
  bool operator ==(covariant Usermodel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.profilePic == profilePic &&
        other.bannerPic == bannerPic &&
        other.bio == bio &&
        other.uid == uid &&
        other.isverified == isverified;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        profilePic.hashCode ^
        bannerPic.hashCode ^
        bio.hashCode ^
        uid.hashCode ^
        isverified.hashCode;
  }
}
