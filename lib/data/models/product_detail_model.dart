import 'product_model.dart';
import 'rateing_model.dart';

class ProductDetailModel {
  ProductModel product;
  final RatingModel rating;

  ProductDetailModel({
    required this.product,
    required this.rating,
  });

  factory ProductDetailModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailModel(
      product: ProductModel.fromMap(map),
      rating: RatingModel.fromMap(map),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ...product.toMap(),
      ...rating.toMap(),
    };
  }

  ProductDetailModel copyWith({
    ProductModel? product,
    RatingModel? rating,
  }) {
    return ProductDetailModel(
      product: product ?? this.product,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() {
    return 'ProductDetailModel(product: $product, rating: $rating)';
  }
}
