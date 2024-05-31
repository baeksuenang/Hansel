import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/item.dart';
import '../models/item_list.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemList = context.watch<ItemList>();

    return Scaffold(
      body: ListView.separated(
        itemCount: itemList.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itemList.items[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditItemDialog(context, itemList, index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    itemList.removeItem(index);
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(), // 리스트 항목 사이에 구분선을 추가
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context, itemList);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context, ItemList itemList) {
    TextEditingController itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: TextField(
            controller: itemController,
            decoration: InputDecoration(hintText: 'Enter item title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (itemController.text.isNotEmpty) {
                  itemList.addItem(itemController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditItemDialog(BuildContext context, ItemList itemList, int index) {
    TextEditingController itemController = TextEditingController();
    itemController.text = itemList.items[index].title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextField(
            controller: itemController,
            decoration: InputDecoration(hintText: 'Enter item title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (itemController.text.isNotEmpty) {
                  itemList.updateItem(index, itemController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}