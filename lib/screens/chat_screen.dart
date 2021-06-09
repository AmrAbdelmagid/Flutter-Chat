import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert,color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app,color: Colors.black,),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (value){
              if (value == 'logout')
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/tfcgzUvOWAYia7O7FLxq/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
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
        onPressed: () {},
      ),
    );
  }
}
