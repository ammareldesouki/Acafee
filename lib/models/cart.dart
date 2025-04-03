import 'package:ammarcafe/models/item_class.dart';
import 'package:flutter/material.dart';

class CartItem {
  final Item item;
  int quantity;
  CartItem({
    required this.item,
    this.quantity = 1,
  });
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Item item) {
    // Check if the item already exists in the cart
    final existingItemIndex =
        _cartItems.indexWhere((CartItem) => CartItem.item.name == item.name);
    if (existingItemIndex != -1) {
      // If it exists, increase the quantity
      _cartItems[existingItemIndex].quantity++;
    } else {
      // If it doesn't exist, add it to the cart
      _cartItems.add(CartItem(item: item));
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void decrementQuantity(Item item) {
    final existingItemIndex =
        _cartItems.indexWhere((CartItem) => CartItem.item.name == item.name);
    if (existingItemIndex != -1) {
      if (_cartItems[existingItemIndex].quantity > 1) {
        _cartItems[existingItemIndex].quantity--;
      } else {
        _cartItems.remove(item);
      }
      notifyListeners();
    }
  }

  void incrementQuantity(Item item) {
    final existingItemIndex =
        _cartItems.indexWhere((CartItem) => CartItem.item.name == item.name);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity++;

      notifyListeners();
    }
  }

  double get totalAmount {
    return _cartItems.fold(0, (sum, cartItem) {
      return sum + (cartItem.item.price * cartItem.quantity);
    });
  }
}
