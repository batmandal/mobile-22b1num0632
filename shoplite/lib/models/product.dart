extension PriceFormat on double {
  String get asPrice => '\$${toStringAsFixed(2)}';
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String category;
  final String thumbnail;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    this.description = '',
    this.discountPercentage = 0,
    this.rating = 0,
    this.stock = 0,
    this.category = '',
    this.thumbnail = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'category': category,
      'thumbnail': thumbnail,
    };
  }

  double get discountedPrice {
    final value = price * (1 - discountPercentage / 100);
    return (value * 100).round() / 100;
  }

  bool get inStock {
    return stock > 0;
  }

  Product copyWith({double? price, int? stock}) {
    return Product(
      id: id,
      title: title,
      price: price ?? this.price,
      description: description,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock ?? this.stock,
      category: category,
      thumbnail: thumbnail,
    );
  }

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Product(#$id $title, \$$price)';
}
