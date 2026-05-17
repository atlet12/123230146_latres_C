import 'package:hive/hive.dart';
import '../models/cart_item_model.dart';

class CartService {
  static const String _boxName = 'cart_box';

  Future<Box<CartItem>> _getBox() async {
    return await Hive.openBox<CartItem>(_boxName);
  }

  Future<void> addToCart(CartItem item) async {
    final box = await _getBox();
    final key = '${item.username}_${item.productId}';

    // Check if item already exists
    final existingKey = box.keys.firstWhere(
      (k) =>
          k == key ||
          (box.get(k)?.username == item.username &&
              box.get(k)?.productId == item.productId),
      orElse: () => null,
    );

    if (existingKey != null) {
      final existingItem = box.get(existingKey);
      if (existingItem != null) {
        existingItem.quantity += item.quantity;
        await box.put(existingKey, existingItem);
      }
    } else {
      await box.put(key, item);
    }
  }

  Future<List<CartItem>> getCartItems(String username) async {
    final box = await _getBox();
    final items = box.values
        .where((item) => item.username == username)
        .toList();
    return items;
  }

  Future<void> removeFromCart(String username, int productId) async {
    final box = await _getBox();
    final key = box.keys.firstWhere(
      (k) =>
          box.get(k)?.username == username &&
          box.get(k)?.productId == productId,
      orElse: () => null,
    );

    if (key != null) {
      await box.delete(key);
    }
  }

  Future<void> updateQuantity(String username, int productId, int quantity) async {
    final box = await _getBox();
    final key = box.keys.firstWhere(
      (k) =>
          box.get(k)?.username == username &&
          box.get(k)?.productId == productId,
      orElse: () => null,
    );

    if (key != null && quantity > 0) {
      final item = box.get(key);
      if (item != null) {
        item.quantity = quantity;
        await box.put(key, item);
      }
    }
  }

  Future<void> clearCart(String username) async {
    final box = await _getBox();
    final keysToDelete = box.keys
        .where((k) => box.get(k)?.username == username)
        .toList();

    for (final key in keysToDelete) {
      await box.delete(key);
    }
  }
}
