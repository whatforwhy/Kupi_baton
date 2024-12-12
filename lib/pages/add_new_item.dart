import 'package:flutter/material.dart';
import 'package:untitled/services/my_button.dart';
import 'package:untitled/services/my_text.dart';

import '../services/add_item.dart';

class AddNewItem extends StatefulWidget {

  final List itemsList;

  const AddNewItem({super.key, required this.itemsList});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  List itemsList = [];
  late String name_item;

  List getListOfItems(){
    return itemsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyText(
                text: 'New item',
                isTitle: true,
                isDeep: true,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'Title',
                isTitle: false,
                isDeep: true
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (String value) {
                  name_item=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              MyButton(
                textButton: 'Add',
                onTap: () {
                  addItem(name_item);
                  Navigator.of(context).pop();
                })
            ],
        ),
      )
    );
  }
}
