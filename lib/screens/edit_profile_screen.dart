import 'package:flutter/material.dart';
import '../app_state.dart';

class EditProfileScreen extends StatefulWidget {
  final VoidCallback onSaved;
  const EditProfileScreen({super.key, required this.onSaved});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _firstCtrl;
  late final TextEditingController _lastCtrl;

  @override
  void initState() {
    super.initState();
    _firstCtrl =
        TextEditingController(text: AppState.instance.firstName);
    _lastCtrl =
        TextEditingController(text: AppState.instance.lastName);
  }

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    super.dispose();
  }

  Widget _field(TextEditingController ctrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0000FF), Color(0xFFB0AFFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.chevron_left,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Редактирование профиля',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Аватар с иконкой камеры
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white30,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.person,
                                size: 60, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Поля
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Имя',
                          style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 6),
                      _field(_firstCtrl),
                      const SizedBox(height: 16),
                      const Text('Фамилия',
                          style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 6),
                      _field(_lastCtrl),
                    ],
                  ),
                ),
              ),

              // Кнопка сохранить
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: GestureDetector(
                  onTap: () {
                    AppState.instance.firstName =
                        _firstCtrl.text.trim();
                    AppState.instance.lastName = _lastCtrl.text.trim();
                    widget.onSaved();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF69B4),
                          Color(0xFF9B5DE5)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text('Сохранить',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
