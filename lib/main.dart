import 'package:custom_soft/screens/home/app.dart';
import 'package:custom_soft/styles/theme/light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getTokenNotifications();
  runApp(const MyApp());
}
getTokenNotifications() {
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    _messaging.getToken().then((d) async {
      print("------Token Messaging: $d");
    });
  }
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const App(),
    );
  }
}
