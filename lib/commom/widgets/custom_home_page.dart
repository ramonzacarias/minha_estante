import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

import 'package:minha_estante/features/home/home_page.dart';
import 'package:minha_estante/features/library/library_page.dart';
import 'package:minha_estante/features/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _currentIndex = 0;

  final List<Widget> _children = [
    const Home(),
    const Library(),
    const ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.greenTwo,
        unselectedItemColor: AppColors.graffite,
        iconSize: 38.0,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil'
          ),
        ],
      ),
    );
  }
}