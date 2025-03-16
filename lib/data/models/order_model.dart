import 'package:dartz/dartz.dart';
import 'package:super_ecommerce/data/models/address_model.dart';

class OrderModel {
  final int id;
  final double totalAmount;
  final String status;
  final AddressModel shippingAddress;
  final String generalStatus;
  final DateTime createdAt;

  final List<OrderItem> items;

  OrderModel({
    required this.id,
    required this.generalStatus,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
    required this.items,
  });

  OrderModel copyWith({
    int? id,
    Map<String, dynamic>? user,
    double? totalAmount,
    String? status,
    AddressModel? shippingAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItem>? items,
    String? generalStatus,
  }) {
    return OrderModel(
      id: id ?? this.id,
      generalStatus: generalStatus ?? this.generalStatus,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total_amount': totalAmount,
      'status': status,
      'shipping_address': shippingAddress,
      'created_at': createdAt.toIso8601String(),
      'items': items.map((x) => x.toJson()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'] as int,
        generalStatus: json['general_status'],
        totalAmount: double.parse(json['total_amount']),
        status: json['status'] as String,
        shippingAddress: AddressModel.fromMap(json['shipping_address']),
        createdAt: DateTime.parse(json['created_at'] as String),
        items: List<OrderItem>.from((json['items'] as List)
            .map((x) => OrderItem.fromMap(x as Map<String, dynamic>))));
  }

  static List<OrderModel> fromListMap(List<dynamic> data) {
    return data.map((map) => OrderModel.fromMap(map)).toList();
  }
}

class OrderItem {
  final int id;
  final Map<String, dynamic> product;
  final int quantity;
  final double price;
  final double discount;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.discount,
  });

  OrderItem copyWith({
    int? id,
    Map<String, dynamic>? product,
    int? quantity,
    double? price,
    double? discount,
  }) {
    return OrderItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
      'price': price,
      'discount': discount,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: json['product'] as Map<String, dynamic>,
      quantity: json['quantity'] as int,
      price: double.parse(json['price']),
      discount: double.parse(json['discount']),
    );
  }
  static List<OrderItem> fromListMap(List<dynamic> data) {
    return data.map((map) => OrderItem.fromMap(map)).toList();
  }
}
