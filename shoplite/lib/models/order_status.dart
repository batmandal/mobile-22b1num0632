enum OrderStatus {
  pending('Хүлээгдэж буй'),
  paid('Төлөгдсөн'),
  shipped('Хүргэлтэд гарсан'),
  delivered('Хүргэгдсэн'),
  cancelled('Цуцлагдсан');

  const OrderStatus(this.label);

  final String label;

  OrderStatus? get next {
    return switch (this) {
      OrderStatus.pending => OrderStatus.paid,
      OrderStatus.paid => OrderStatus.shipped,
      OrderStatus.shipped => OrderStatus.delivered,
      OrderStatus.delivered => null,
      OrderStatus.cancelled => null,
    };
  }

  bool get canCancel {
    return switch (this) {
      OrderStatus.pending || OrderStatus.paid => true,
      OrderStatus.shipped ||
      OrderStatus.delivered ||
      OrderStatus.cancelled =>
        false,
    };
  }
}
