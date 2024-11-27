import 'package:kues/listvew_with_filters/domain/entity/character.dart';

class CartRepository {
  final List<Character> _items = [];

  List<Character> get items => List.unmodifiable(_items);

  void addItem(Character item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingIndex != -1) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity! + 1,
      );
    } else {
      _items.add(item);
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void clearCart() {
    _items.clear();
  }

  double get totalPrice =>
      _items.fold(0, (total, item) => total + (item.quantity! * item.quantity!));
}
