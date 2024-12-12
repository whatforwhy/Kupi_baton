import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/services/my_button.dart';
import 'package:untitled/services/my_text.dart';



class Profile1 extends StatefulWidget {

  @override
  State<Profile1> createState() => _Profile();
}

class _Profile extends State<Profile1>{
  String about_me = '';
  String username = '';

  //final user = FirebaseAuth.instance.currentUser!;

  void userOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/reg');
  }
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    var snapshot = FirebaseFirestore.instance.collection('Users').snapshots();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: MyText(text: 'Profile', isTitle: true, isDeep: true)
        ),
        body: StreamBuilder(
          stream: snapshot,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return Text('Loading');
              return Padding(
                padding: EdgeInsets.all(40),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data!.docs[index].get('uid') ==
                        FirebaseAuth.instance.currentUser?.uid)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(text: 'Information ', isTitle: false, isDeep: true),
                          Text(snapshot.data!.docs[index].get('username')),
                          Text(snapshot.data!.docs[index].get('email')),
                          Padding(padding: EdgeInsets.only(top: 25)),
                          MyText(text: 'About me:', isTitle: false, isDeep: true),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(snapshot.data!.docs[index].get('about_me')
                                  )
                                )
                              ],
                            )
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage('assets/pencil.png'), width: 30, height: 30),
                                Padding(padding: EdgeInsets.only(right: 10)),
                                Text('Change information', style: TextStyle(color: Colors.black, fontSize: 20, decoration: TextDecoration.underline),)
                              ],
                            ),
                            onPressed: () {
                              showDialog(context: context, builder: (BuildContext context) {
                                return Scaffold(
                                  resizeToAvoidBottomInset: false,
                                  appBar: AppBar(),
                                  body: Padding(
                                    padding: EdgeInsets.all(60),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(text: 'Name:', isTitle: false, isDeep: true),
                                        TextField(
                                          onChanged: (String value) {
                                            username = value;
                                          },
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 30)),
                                        MyText(text: 'About me: ', isTitle: false, isDeep: true),
                                        TextField(
                                          onChanged: (String value) {
                                            about_me = value;
                                          },
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 50)),
                                        MyButton(
                                            textButton: 'Save',
                                            onTap: () {
                                              if (username != ''){
                                                Map<String, String> ref = {
                                                  'username': username,
                                                };
                                                FirebaseFirestore.instance.collection('Users').
                                                doc(currentUser.uid).update(ref);
                                              }
                                              if (about_me != '') {
                                                Map<String, String> ref = {
                                                  'about_me': about_me,
                                                };
                                                FirebaseFirestore.instance.collection('Users').
                                                doc(currentUser.uid).update(ref);
                                              }
                                              Navigator.of(context).pop();
                                            }
                                        )
                                      ],
                                    )
                                  ),
                                  bottomSheet: TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.logout, size: 20, color: Colors.grey,),
                                        Padding(padding: EdgeInsets.only(right: 10)),
                                        Text('Exit', style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            decoration: TextDecoration.lineThrough,
                                            decorationColor: Color.fromARGB(30, 0, 0, 0),
                                        ))
                                        ],
                                    ),
                                    onPressed: userOut,
                                  )
                                );
                              });
                            },
                          ),

                        ],
                      );
                      else return Padding(padding: EdgeInsets.zero);
                  }
                )
              );
          }
        ),
    );
  }
}

