import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection('chats/tfcgzUvOWAYia7O7FLxq/messages').snapshots() ,
        builder: (ctx , streamSnapshot) {
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemBuilder: (ctx, i) => Container(
              padding: EdgeInsets.all(8.0),
              child: Text(documents[i]['text']),
            ),
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}
