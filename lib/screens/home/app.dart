import 'dart:developer';

import 'package:custom_soft/screens/home/home.dart';
import 'package:custom_soft/screens/not_found.dart';
import 'package:custom_soft/styles/colors.dart';
import 'package:custom_soft/util/notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget{
   static const String routeName = "/base";
  const App({super.key});
  
  @override
  State<StatefulWidget> createState()=> _App();
}
class _App extends State<App>{
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  PushNotificationsService notificationService = PushNotificationsService();
  final List<Map<String,Widget>> _screens = const [
    {"Buscador Anuncio" : Home()},
    {"Not Found" : NotFound()}
  ];
  int indexScreen = 0;

  @override
  void initState(){
    super.initState();
    notificaciones();
  }

  Future<void> notificaciones() async {
    log("Inicio de notificaciones");
    notificationService.init();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('''
        message on Resumen
        data: ${message.data}
        body: ${message.notification!.body} 
        title: ${message.notification!.title}
        ''');
      notificationService.showNotifications(
        "${message.notification!.title}", "${message.notification!.body}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("______ message Navigator");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(_screens[indexScreen].keys.first),
      ),
      body: _screens[indexScreen].values.first,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: UIColors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem
            (icon: Icon(Icons.shopping_bag_outlined), label: 'Tienda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'perfil'),
        ]
      ),
    );
  }
  
}