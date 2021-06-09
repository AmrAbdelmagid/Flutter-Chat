import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').snapshots(),builder: (ctx, dataSnapshot) {
      if (dataSnapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      final chatDocs = dataSnapshot.data.docs;
      return Expanded(child: ListView.builder(itemBuilder: (ctx , i) => Text(chatDocs[i]['text']),itemCount:chatDocs.length,));
    });
  }
}
