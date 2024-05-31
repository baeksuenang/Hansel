import 'package:flutter/foundation.dart';
import 'item.dart';

class ItemList with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(String title) {
    _items.add(Item(title: title));
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateItem(int index, String title) {
    _items[index].title = title;
    notifyListeners();
  }
}
