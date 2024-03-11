class CartItem {
  final String imageUrl;
  final String title;
  final double price;
  final String description;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.quantity,
  });

  CartItem copyWith({
    String? imageUrl,
    String? title,
    double? price,
    String? description,
    int? quantity,
  }) {
    return CartItem(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }

  void updateQuantity(int newQuantity) {
    // Ensure the new quantity is non-negative
    if (newQuantity >= 0) {
      quantity = newQuantity;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.imageUrl == imageUrl &&
        other.title == title &&
        other.price == price &&
        other.description == description &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        title.hashCode ^
        price.hashCode ^
        description.hashCode ^
        quantity.hashCode;
  }
}
