import 'models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  int selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedSize,
  });
}

class AppState {
  static final AppState instance = AppState._();
  AppState._();

  List<CartItem> cartItems = [];
  String firstName = 'Travis';
  String lastName = 'Scott';

  String get fullName => '$firstName $lastName';

  CartItem? itemFor(String productId) {
    for (final item in cartItems) {
      if (item.product.id == productId) return item;
    }
    return null;
  }

  void addToCart(Product product) {
    final existing = itemFor(product.id);
    if (existing != null) {
      existing.quantity++;
    } else {
      cartItems.add(CartItem(
        product: product,
        selectedSize: product.sizes.first,
      ));
    }
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((i) => i.product.id == productId);
  }

  double get total =>
      cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  void clearCart() => cartItems.clear();
}
