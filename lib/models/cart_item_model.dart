import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productTitle;

  @HiveField(2)
  final double productPrice;

  @HiveField(3)
  final String productImage;

  @HiveField(4)
  int quantity;

  @HiveField(5)
  final String username;

  @HiveField(6)
  final int stock;

  CartItem({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
    required this.username,
    required this.stock,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] ?? 0,
      productTitle: json['productTitle'] ?? '',
      productPrice: (json['productPrice'] ?? 0).toDouble(),
      productImage: json['productImage'] ?? '',
      quantity: json['quantity'] ?? 1,
      username: json['username'] ?? '',
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productImage': productImage,
      'quantity': quantity,
      'username': username,
      'stock': stock,
    };
  }

  double get totalPrice => productPrice * quantity;
}
