import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String image;
  final String username;

  MessageBubble(this.message, this.isMe, this.username, this.image, {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            width: 140.0,
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color),
                ),
                Text(
                  message,
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color),
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: -10,
      left: isMe ? null : 120.0,
          right: isMe ? 120.0 : null,
          child: CircleAvatar(
        backgroundImage: NetworkImage(image),
      )),
    ],clipBehavior:Clip.none ,);
  }
}
