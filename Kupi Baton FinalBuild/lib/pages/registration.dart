import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/create_user.dart';
import 'package:untitled/services/my_button.dart';

import 'menu.dart';

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _Reg();
}

class _Reg extends State<Reg> {

  String password ='';
  String email = '';
  String name = '';
  String emailC = '';
  String passwordC = '';
  CollectionReference usercollection =
  FirebaseFirestore.instance.collection('Users');

  @override
  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child:Scaffold(
            resizeToAvoidBottomInset: false,
            body: DefaultTabController(
              length: 2,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Color.fromARGB(30, 0, 0, 0),
                      indicatorColor: Color.fromARGB(30, 53, 29, 71),
                      indicatorWeight: 5,
                      tabs: [
                        Tab(text: 'Sign in', height: 50,),
                        Tab(text: 'Create new account', height: 50),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                  Padding(
                    padding: EdgeInsets.all(17),
                    child:Column(
                      children: [
                        Text('Email', style: TextStyle(fontSize: 30),),
                        TextField(
                          onChanged: (String value) {
                            emailC = value;
                          },
                        ),
                        Text('Password', style: TextStyle(fontSize: 30)),
                        TextField(
                          obscureText: true,
                          onChanged: (String value) {
                            passwordC = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        MyButton(
                            textButton: 'Sing in',
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: emailC,
                                    password: passwordC
                                );
                              } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AnimatedOpacity(
                                              opacity: 1.0,
                                              duration: Duration(seconds: 3),
                                              child: AlertDialog(
                                                  backgroundColor: Color.fromARGB(60, 53, 29, 71),
                                                  title: Text(
                                                    'User not found',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 50,
                                                      fontWeight: FontWeight.bold,
                                                    ),)
                                              )
                                          );
                                        }
                                    );
                                  }
                                  else if (e.code == 'wrong-password'){
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AnimatedOpacity(
                                                opacity: 1.0,
                                                duration: Duration(seconds: 3),
                                            child: AlertDialog(
                                            backgroundColor: Color.fromARGB(60, 53, 29, 71),
                                            title: Text(
                                            'Wrong password or Email',
                                            style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            ),)
                                            )
                                            );
                                          }
                                      );
                                  }
                              }
                            }
                        ),
                        Expanded(child: Image.asset('assets/first.png'))
                      ],
                    ),
                  ),
                      Padding(
                          padding: EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Text('Name', style: TextStyle(fontSize: 20)),
                              TextField(
                                onChanged: (String value) {
                                  name = value;
                                },
                              ),
                              Text('Email', style: TextStyle(fontSize: 20)),
                              TextField(
                                onChanged: (String value) {
                                  email = value;
                                },
                              ),
                              Text('Password', style: TextStyle(fontSize: 20)),
                              TextField(
                                obscureText: true,
                                onChanged: (String value) {
                                  password = value;
                                },
                              ),
                              Padding(padding: EdgeInsets.only(top: 30)),
                              MyButton(
                                onTap: () async {
                                  try {
                                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );
                                    createUser('', email, name, FirebaseAuth.instance.currentUser?.uid);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print('The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                      print('The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Menu()),
                                  );
                                },
                                textButton: 'Create new account',
                                ),

                              ],
                            ) ,
                      )
                    ],
                  ),
                ),
              ),
        )
    );
  }
}
