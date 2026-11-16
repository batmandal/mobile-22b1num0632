import 'package:flutter/material.dart';

import '../models/product.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          product.discountedPrice.asPrice,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        if (product.discountPercentage > 0)
          Text(
            product.price.asPrice,
            style: theme.textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: theme.colorScheme.outline,
            ),
          ),
      ],
    );
  }
}
