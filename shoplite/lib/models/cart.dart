import 'product.dart';

class OutOfStockException implements Exception {
  final Product product;
  final int requested;

  OutOfStockException(this.product, this.requested);

  @override
  String toString() =>
      '${product.title}: $requested ширхэг хүссэн, нөөцөд ${product.stock} байна';
}

class CartItem {
  final Product product;
  final int quantity;

  const CartItem(this.product, this.quantity);

  double get subtotal {
    return product.discountedPrice * quantity;
  }
}

class Cart {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => List.unmodifiable(_items.values);

  bool get isEmpty => _items.isEmpty;

  int get totalQuantity {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    final total =
        _items.values.fold(0.0, (sum, item) => sum + item.subtotal);
    return (total * 100).round() / 100;
  }

  void add(Product product, {int quantity = 1}) {
    if (quantity <= 0) {
      throw ArgumentError.value(quantity, 'quantity', 'must be positive');
    }
    final current = _items[product.id]?.quantity ?? 0;
    final newQuantity = current + quantity;
    if (newQuantity > product.stock) {
      throw OutOfStockException(product, newQuantity);
    }
    _items[product.id] = CartItem(product, newQuantity);
  }

  void decrease(int productId) {
    final item = _items[productId];
    if (item == null) return;
    if (item.quantity <= 1) {
      _items.remove(productId);
    } else {
      _items[productId] = CartItem(item.product, item.quantity - 1);
    }
  }

  void remove(int productId) => _items.remove(productId);

  void clear() => _items.clear();
}
