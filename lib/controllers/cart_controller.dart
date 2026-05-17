import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  var cartItems = <CartItem>[].obs;
  var currentUsername = ''.obs;

  void setUsername(String username) {
    currentUsername(username);
  }

  Future<void> loadCart(String username) async {
    if (username.isEmpty) return;
    final items = await _cartService.getCartItems(username);
    cartItems.assignAll(items);
  }

  void addToCart(CartItem item) async {
    await _cartService.addToCart(item);
    currentUsername(item.username);
    await loadCart(item.username);
  }

  void removeFromCart(int productId) async {
    await _cartService.removeFromCart(currentUsername.value, productId);
    await loadCart(currentUsername.value);
  }

  void updateQuantity(int productId, int quantity) async {
    await _cartService.updateQuantity(currentUsername.value, productId, quantity);
    await loadCart(currentUsername.value);
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.totalPrice;
    }
    return total;
  }

  int get itemCount => cartItems.length;
}
