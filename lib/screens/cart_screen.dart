import 'package:flutter/material.dart';
import '../app_state.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onCartChanged;
  final VoidCallback onBack; // переключает на вкладку «главная»
  const CartScreen({
    super.key,
    required this.onCartChanged,
    required this.onBack,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _rebuild() {
    setState(() {});
    widget.onCartChanged();
  }

  @override
  Widget build(BuildContext context) {
    final cart = AppState.instance.cartItems;

    return Container(
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
                    onTap: widget.onBack, // ← работающая кнопка назад
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
                    'Корзина',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Список товаров
            Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Text(
                        'Корзина пуста',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cart.length,
                      itemBuilder: (context, i) => _CartItemWidget(
                        item: cart[i],
                        onChanged: _rebuild,
                      ),
                    ),
            ),

            // Нижняя панель
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.electric_moped, color: Colors.white),
                          SizedBox(width: 6),
                          Text('2-3 дня',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Text(
                        'Итого: ${AppState.instance.total.toInt()} р.',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _GradientButton(
                    label: 'Оформить',
                    onTap: cart.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutScreen(
                                  onOrderPlaced: _rebuild,
                                ),
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
class _CartItemWidget extends StatefulWidget {
  final CartItem item;
  final VoidCallback onChanged;
  const _CartItemWidget({required this.item, required this.onChanged});

  @override
  State<_CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<_CartItemWidget> {
  bool _showSizes = false;

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
            color: Color(0xFF3333FF), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.product.imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                width: 90,
                height: 90,
                color: Colors.grey[200],
                child:
                    const Icon(Icons.shopping_bag, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                Text('${item.product.price.toInt()} Р.',
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 8),

                // Выбор размера
                GestureDetector(
                  onTap: () =>
                      setState(() => _showSizes = !_showSizes),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3333FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'размер\n${item.selectedSize}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
                if (_showSizes)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: item.product.sizes
                          .map((s) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item.selectedSize = s;
                                    _showSizes = false;
                                  });
                                  widget.onChanged();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: s == item.selectedSize
                                        ? const Color(0xFF3333FF)
                                        : Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '$s',
                                    style: TextStyle(
                                      color: s == item.selectedSize
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 8),

                // Кол-во
                Row(
                  children: [
                    _circleBtn(Icons.remove, () {
                      if (item.quantity > 1) {
                        item.quantity--;
                      } else {
                        AppState.instance
                            .removeFromCart(item.product.id);
                      }
                      widget.onChanged();
                    }),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('${item.quantity}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    _circleBtn(Icons.add, () {
                      item.quantity++;
                      widget.onChanged();
                    }),
                    const Spacer(),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3333FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check,
                          color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _GradientButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: onTap == null
                ? [Colors.grey, Colors.grey]
                : [const Color(0xFFFF69B4), const Color(0xFF9B5DE5)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
