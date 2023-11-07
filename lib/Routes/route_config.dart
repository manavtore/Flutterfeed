import 'package:flutter/material.dart';
import 'package:flutterfeed/Tweet/services/create_tweet_view.dart';
import 'package:flutterfeed/view/main/homescreen.dart';
import 'package:flutterfeed/view/auth/create_account.dart';
import 'package:flutterfeed/view/auth/loginPage.dart';
import 'package:flutterfeed/view/page/profileScreen.dart';
import 'package:flutterfeed/view/auth/signInPage.dart';
import 'package:flutterfeed/view/auth/signup.dart';
import 'package:go_router/go_router.dart';

class Approuter {
  GoRouter router = GoRouter(initialLocation: '/homescreen', routes: <GoRoute>[
    GoRoute(
      name: 'signin',
      path: '/signin',
      pageBuilder: (context, state) {
        return const MaterialPage(child: signinpage());
      },
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      pageBuilder: (context, state) {
        return const MaterialPage(child: sign_up());
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (context, state) {
        return const MaterialPage(child: loginpage());
      },
    ),
    GoRoute(
      name: 'create Account',
      path: '/createaccount',
      pageBuilder: (context, state) {
        return const MaterialPage(child: create_account());
      },
    ),
    GoRoute(
        name: 'home',
        path: '/homescreen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: homescreen());
        }),
    GoRoute(
        name: 'createTweet',
        path: '/createTweet',
        pageBuilder: (context, state) {
          return const MaterialPage(child: CreateTweetScreen());
        }),
    GoRoute(
        name: 'Profilescreen',
        path: '/profilescreen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProfileScreen());
        }),
  ]);
}
