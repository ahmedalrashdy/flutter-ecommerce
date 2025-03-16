import 'dart:developer';

import 'package:get/get.dart';
import 'package:super_ecommerce/data/repositories/product_repository.dart';

class ProductModel {
  static final Map<int, ProductModel> appProducts = {};
  static final Map<int, ProductModel> favoriteProducts = {};
  int id;
  String name;
  String? description;
  double price;
  double discount;
  int categoryId;
  String mainImage;
  List<String> additionalImages;
  double rating;
  bool isFavorite;
  bool isInCart;
  ProductModel(
      {required this.id,
      required this.name,
      this.description,
      required this.price,
      this.discount = 0,
      required this.categoryId,
      required this.mainImage,
      this.additionalImages = const [],
      required this.rating,
      this.isFavorite = false,
      this.isInCart = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount_price': discount,
      'category': categoryId,
      'main_image': mainImage,
      "isFavorite": isFavorite,
      "is_in_cart": isInCart
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    if (appProducts.containsKey(map['id'])) {
      int id = map['id'];
      log("منتج متشابه رقم $id");

      appProducts[id]!.id = map['id'];
      appProducts[id]!.name = map['name'];
      appProducts[id]!.description = map['description'];
      appProducts[id]!.price = double.parse(map['price']);
      appProducts[id]!.discount = double.parse(map['discount_price']);
      appProducts[id]!.categoryId = map['category'];
      appProducts[id]!.mainImage = map['main_image'];
      appProducts[id]!.rating = map['rating'];
      appProducts[id]!.isInCart = map['is_in_cart'] ?? false;
      appProducts[id]!.isFavorite = favoriteProducts.containsKey(id);
      return appProducts[id]!;
    }
    ProductModel product = ProductModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: double.parse(map['price']),
        discount: double.parse(map['discount_price']),
        categoryId: map['category'],
        mainImage: map['main_image'],
        rating: map['rating'],
        isFavorite: favoriteProducts.containsKey(map['id']),
        isInCart: map['is_in_cart'] ?? false);
    appProducts[product.id] = product;
    return product;
  }

  static List<ProductModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((map) => ProductModel.fromMap(map)).toList();
  }

  static ProductRepository productRepository = Get.find();
  static void getFavoriteList() {
    final result = productRepository.getFavorites();
    result.fold((failure) {}, (products) {
      for (ProductModel prod in products) {
        favoriteProducts[prod.id] = prod;
      }
    });
  }
}
