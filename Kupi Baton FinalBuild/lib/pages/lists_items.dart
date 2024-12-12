import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/item_class.dart';
import 'package:untitled/pages/add_new_item.dart';


import '../services/my_text.dart';

class ListOfItems extends StatefulWidget {
  const ListOfItems({super.key});

  @override
  State<ListOfItems> createState() => _ShopListState();
}

class _ShopListState extends State<ListOfItems> {
  double _opacity = 1.0;
  List ShopLists = [];

  @override
  void initState() {
    super.initState();
    ShopLists.addAll([]);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: MyText(text: 'Shopping list', isTitle: true, isDeep: true),
      ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('item').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData) return Center(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Text('No items yet', textAlign: TextAlign.center,style: TextStyle(
                fontSize: 24,)),
              SizedBox(width: 20),//
              AnimatedOpacity(
              opacity: _opacity,  //
              duration: Duration(seconds: 5),
              child: Image.asset(
              'assets/second.png',  // ADD PIC
              width: 100,
              height: 100,)
                ,)
                        ,]
                    ,)
                ,);
              return Padding(
                  padding: EdgeInsets.all(30),
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data!.docs[index].get('user') ==
                              FirebaseAuth.instance.currentUser?.uid)
                            return Card(
                              borderOnForeground: false,
                              margin: EdgeInsets.only(bottom: 20),
                              child: Dismissible(
                                  key: Key(snapshot.data!.docs[index].id),
                                  child: classHabit(state1: snapshot.data!
                                      .docs[index].get('name'),

                                  ),
                                  onDismissed: (direction) {
                                    FirebaseFirestore.instance.collection('item')
                                        .doc(snapshot.data!.docs[index].id).delete();
                                  },
                                background: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Delete  ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Image.asset(
                                        'assets/rubbishbin.png',
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 20))
                                  ],
                                ),
                              ),
                            );
                          else return Padding(padding: EdgeInsets.zero);
                    }
                  )
              );
            }
        ),

          floatingActionButton: Container(
            width: 80,
            height: 80,
            child : FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AddNewItem(itemsList: ShopLists);
            });
          },

            child: Icon(Icons.add, color: Colors.white, size: 40),
            backgroundColor: Color.fromARGB(255, 53, 29, 71)
        ),)
    );
  }
}