class CartItemModel {
  final int productId;
  final double price;
  final double discountPrice;
  final String mainImage;
  final String description;
  final String name;
  final int id;
  int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.price,
    required this.discountPrice,
    required this.mainImage,
    required this.description,
    required this.quantity,
    required this.name,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      productId: map['product_id'],
      price: double.parse(map['price']),
      discountPrice: double.parse(map['discount_price']),
      mainImage: map['main_image'],
      description: map['description'] ?? "",
      quantity: map['quantity'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'price': price,
      'discount_price': discountPrice,
      'main_image': mainImage,
      'description': description,
      'quantity': quantity,
      'name': name,
    };
  }

  static List<CartItemModel> fromMapList(List<dynamic> data) {
    return data.map((item) => CartItemModel.fromMap(item)).toList();
  }
}
