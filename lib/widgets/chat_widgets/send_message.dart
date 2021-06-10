import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  var _textController = TextEditingController();
  var _sentMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _sentMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username' : userData['username'],
    });
    _sentMessage = '';
    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            onChanged: (value) {
              setState(() {
                _sentMessage = value;
              });
            },
            controller: _textController,
            decoration: InputDecoration(labelText: 'Type a message'),
          )),
          IconButton(
            onPressed: _sentMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
