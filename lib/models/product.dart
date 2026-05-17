class Product {
  final String id;
  final String name;
  final double price;
  final String imagePath; // assets/images/shoe_X.png
  final List<int> sizes;
  final String sizeRange;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.sizes,
    required this.sizeRange,
  });

  static final List<Product> catalog = [
    Product(
      id: '1',
      name: 'NIKE AIR FORCE 1',
      price: 12399,
      imagePath: 'assets/images/shoe_1.png',
      sizes: [38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
      sizeRange: '38-47',
    ),
    Product(
      id: '2',
      name: 'NIKE AIR FORCE 1 HIGH',
      price: 14399,
      imagePath: 'assets/images/shoe_2.png',
      sizes: [39, 40, 41, 42, 43, 44, 45, 46, 47],
      sizeRange: '39-47',
    ),
    Product(
      id: '3',
      name: 'NIKE AIR FORCE 1 Jord...',
      price: 12399,
      imagePath: 'assets/images/shoe_3.png',
      sizes: [38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
      sizeRange: '38-47',
    ),
    Product(
      id: '4',
      name: 'NIKE AIR FORCE 1',
      price: 12399,
      imagePath: 'assets/images/shoe_4.png',
      sizes: [38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
      sizeRange: '38-47',
    ),
  ];
}
