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
  double itemWidth = 0.0;

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

  Widget build(BuildContext context) {
    itemWidth =
        MediaQuery.of(context).size.width / 3; // Calcula a largura de cada item

    return Scaffold(
      body: _children[
          _currentIndex], // Exibe o widget correspondente ao índice atual
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            selectedItemColor: AppColors.greenTwo,
            unselectedItemColor: AppColors.graffite,
            iconSize: 38.0,
            currentIndex: _currentIndex, // Índice do item selecionado
            onTap: onTabTapped, // Função chamada quando um item é selecionado
            items: [
              _buildBottomNavigationBarItem(
                Icons.home_outlined,
                'Início',
                0,
              ),
              _buildBottomNavigationBarItem(
                Icons.my_library_books,
                'Biblioteca',
                1,
              ),
              _buildBottomNavigationBarItem(
                Icons.person_outline,
                'Perfil',
                2,
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomBarIndicator(
                    _currentIndex, 0, itemWidth), // Indicador do primeiro item
                _buildBottomBarIndicator(
                    _currentIndex, 1, itemWidth), // Indicador do segundo item
                _buildBottomBarIndicator(
                    _currentIndex, 2, itemWidth), // Indicador do terceiro item
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarIndicator(
      int currentIndex, int itemIndex, double itemWidth) {
    return Container(
      height: 2.0,
      width: itemWidth, // Define a largura do indicador de acordo com itemWidth
      color: currentIndex == itemIndex
          ? AppColors.greenOne
          : Colors
              .transparent, // Define a cor do indicador com base no índice atual
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
