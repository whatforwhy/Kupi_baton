import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void addItem(String name){
  CollectionReference habit_ref =
  FirebaseFirestore.instance.collection('item');
  Map<String, String> dataToSend = {
    'name': name,
    'user': FirebaseAuth.instance.currentUser!.uid,
  };
  habit_ref.doc().set(dataToSend);
}