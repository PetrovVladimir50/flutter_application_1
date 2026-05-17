import 'package:flutter/material.dart';
import '../models/product.dart';
import '../app_state.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onCartChanged;

  const ProductCard({
    super.key,
    required this.product,
    required this.onCartChanged,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  CartItem? get _cartItem => AppState.instance.itemFor(widget.product.id);

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFF3333FF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _productImage() {
    return Image.asset(
      widget.product.imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (context, error, stack) => Container(
        color: Colors.grey[100],
        child: const Center(
          child: Icon(Icons.shopping_bag, size: 50, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = _cartItem;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: _productImage(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.product.sizeRange,
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Text(
                  '${widget.product.price.toInt()} Р.',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 6),
                if (item == null)
                  SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3333FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        AppState.instance.addToCart(widget.product);
                        setState(() {});
                        widget.onCartChanged();
                      },
                      child: const Text('В корзину',
                          style: TextStyle(fontSize: 12)),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleBtn(Icons.remove, () {
                        if (item.quantity > 1) {
                          item.quantity--;
                        } else {
                          AppState.instance.removeFromCart(widget.product.id);
                        }
                        setState(() {});
                        widget.onCartChanged();
                      }),
                      Text('${item.quantity}',
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      _circleBtn(Icons.add, () {
                        item.quantity++;
                        setState(() {});
                        widget.onCartChanged();
                      }),
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
