import '../models/product.dart';

int gridColumnCount(double width) {
  if (width < 600) return 2;
  if (width < 900) return 3;
  return 4;
}

List<String> categoriesOf(Iterable<Product> products) {
  return {
    for (final p in products)
      if (p.category.isNotEmpty) p.category,
  }.toList()
    ..sort();
}

List<Product> filterProducts(
  Iterable<Product> products, {
  String? category,
  String query = '',
}) {
  final q = query.trim().toLowerCase();
  return products
      .where((p) => category == null || p.category == category)
      .where((p) => q.isEmpty || p.title.toLowerCase().contains(q))
      .toList();
}
