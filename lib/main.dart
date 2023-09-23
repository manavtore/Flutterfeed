import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfeed/Routes/route_config.dart';
import 'package:flutterfeed/providers/firebase_provider.dart';
import 'package:flutterfeed/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfeed/view/page/create_account.dart';
import 'package:flutterfeed/view/page/signInPage.dart';
import 'package:flutterfeed/view/page/signup.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.theme,
      routerConfig: Approuter().router,
    );
  }
}
