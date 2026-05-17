import 'package:flutter/material.dart';
import '../app_state.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onUpdate;
  const ProfileScreen({super.key, required this.onUpdate});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white70),
          title: Text(label,
              style: const TextStyle(color: Colors.white70)),
          trailing: const SizedBox.shrink(),
          contentPadding: EdgeInsets.zero,
        ),
        const Divider(color: Colors.white24, height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // SizedBox.expand гарантирует что градиент заполняет весь экран
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0000FF), Color(0xFFB0AFFF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Кнопка редактирования
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfileScreen(
                              onSaved: widget.onUpdate,
                            ),
                          ),
                        );
                        setState(() {});
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ),

                // Аватар
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white30,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  AppState.instance.fullName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Способ оплаты
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Способ оплаты',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Text('Основной способ оплаты',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                            SizedBox(width: 8),
                            Text('|',
                                style: TextStyle(color: Colors.white30)),
                            SizedBox(width: 8),
                            Text('visa ***0345',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_down,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Статистика — без разделительных черт
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _stat('23', 'заказа'),
                    _stat('3', 'Избранных\nмагазина'),
                  ],
                ),
                const SizedBox(height: 20),
                _stat('5', 'предзаказов'),
                const SizedBox(height: 28),

                // Меню
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _menuItem(
                          Icons.star_outline, 'Оценить приложение'),
                      _menuItem(Icons.help_outline, 'Поддержка'),
                      _menuItem(Icons.description_outlined,
                          'Политика конфиденциальности'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
