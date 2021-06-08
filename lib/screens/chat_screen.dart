import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) => Container(
          padding: EdgeInsets.all(8.0),
          child: Text('this works!'),
        ),
        itemCount: 10,
      ),
    );
  }
}
