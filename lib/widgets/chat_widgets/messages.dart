import 'package:chat_app_2/widgets/chat_widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final chatDocs = dataSnapshot.data.docs;
          return Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => MessageBubble(
              chatDocs[i]['text'],
              chatDocs[i]['userId'] == user.uid,
              chatDocs[i]['username'],
              chatDocs[i]['userImage'],
              key: ValueKey(chatDocs[i].id),
            ),
            itemCount: chatDocs.length,
            reverse: true,
          ));
        });
  }
}
