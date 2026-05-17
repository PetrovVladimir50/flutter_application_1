import 'package:flutter/material.dart';
import '../app_state.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final VoidCallback onOrderPlaced;
  const CheckoutScreen({super.key, required this.onOrderPlaced});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _streetCtrl = TextEditingController();
  final _buildingCtrl = TextEditingController();
  final _aptCtrl = TextEditingController();
  final _commentCtrl = TextEditingController();

  @override
  void dispose() {
    _streetCtrl.dispose();
    _buildingCtrl.dispose();
    _aptCtrl.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  Widget _field(TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = AppState.instance.cartItems;

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Товары
                      ...cart.map(
                        (item) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item.product.imagePath,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stack) =>
                                          Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.white30,
                                    child: const Icon(Icons.shopping_bag,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold,
                                            fontSize: 13)),
                                    Text(
                                        'размер ${item.selectedSize}',
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12)),
                                    Text('${item.quantity} шт.',
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              Text(
                                '${(item.product.price * item.quantity).toInt()} Р.',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      const Text('Адрес доставки',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Улица',
                          style: TextStyle(color: Colors.white70)),
                      _field(_streetCtrl, 'Улица'),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text('Дом',
                                    style: TextStyle(
                                        color: Colors.white70)),
                                _field(_buildingCtrl, ''),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text('Квартира',
                                    style: TextStyle(
                                        color: Colors.white70)),
                                _field(_aptCtrl, ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Text('Комментарий для курьера',
                          style: TextStyle(color: Colors.white70)),
                      _field(_commentCtrl, '', maxLines: 3),
                      const Divider(color: Colors.white30, height: 24),

                      const Text('Способ оплаты',
                          style: TextStyle(color: Colors.white70)),
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
                            Text('visa ***0345',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15)),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_down,
                                color: Colors.white70),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white30),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ИТОГ: ${AppState.instance.total.toInt()} рублей',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: GestureDetector(
                  onTap: () {
                    AppState.instance.clearCart();
                    widget.onOrderPlaced();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SuccessScreen()),
                    );
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
                      child: Text('Оплатить',
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
