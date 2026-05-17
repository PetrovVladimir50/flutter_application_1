import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'app_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  void _refresh() => setState(() {});
  void _goHome() => setState(() => _selectedIndex = 1);

  @override
  Widget build(BuildContext context) {
    final screens = [
      ProfileScreen(onUpdate: _refresh),
      HomeScreen(onCartChanged: _refresh),
      CartScreen(
        onCartChanged: _refresh,
        onBack: _goHome, // ← кнопка «назад» в корзине → главная
      ),
    ];

    final cartCount = AppState.instance.cartItems.length;

    return Scaffold(
      // Цвет фона совпадает с нижней точкой градиента — нет белых пробелов
      backgroundColor: const Color(0xFFB0AFFF),
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2222EE), Color(0xFF5555CC)],
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'профиль',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'главная',
            ),
            BottomNavigationBarItem(
              icon: _cartIcon(cartCount, active: false),
              activeIcon: _cartIcon(cartCount, active: true),
              label: 'корзина',
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartIcon(int count, {required bool active}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(active
            ? Icons.shopping_basket
            : Icons.shopping_basket_outlined),
        if (count > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFFFF69B4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 9),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
