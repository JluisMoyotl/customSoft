import 'package:custom_soft/screens/home/home.dart';
import 'package:custom_soft/screens/not_found.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget{
   static const String routeName = "/base";
  const App({super.key});
  
  @override
  State<StatefulWidget> createState()=> _App();
}
class _App extends State<App>{
  final List<Widget> _screens = const [
    Home(),
    NotFound()
  ];
  int indexScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
      ),
      body: _screens[indexScreen],
      bottomNavigationBar: BottomNavigationBar(
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