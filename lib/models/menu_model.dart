class MenuModel {
  final String id;
  final String name;
  final int price; // in Rupiah, integer
  final String category;
  final double discount; // 0.0 - 1.0

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0.0,
  });

  /// Mengembalikan harga setelah diskon (int)
  int getDiscountedPrice() {
    final discounted = price - (price * discount);
    return discounted.toInt();
  }

  // Untuk memudahkan perbandingan/penyimpanan dalam map keyed by id
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
