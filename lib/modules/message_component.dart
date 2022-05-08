
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'message.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({Key key, this.msg}) : super(key: key);
  final Message msg;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var date = msg.createAt.toDate().toLocal();
    return Row(
      mainAxisAlignment: msg.isMe ? MainAxisAlignment.end:MainAxisAlignment.start ,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: msg.isMe? Colors.deepOrangeAccent : HexColor("#f29268"),
               borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(10) ,
                   topRight: Radius.circular(10),
                    bottomLeft: msg.isMe ? Radius.circular(10):
                    Radius.circular(0),
                 bottomRight:msg.isMe ? Radius.circular(0):
                     Radius.circular(10)
               )

              ),
              constraints:
            BoxConstraints(
              minWidth: 30,
              minHeight: 40,
              maxWidth: width/1.1
            ),
              child:
                  Text(
                    msg.content,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),

                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child:
              Container(
                padding: EdgeInsets.only(
                  right: 5,
                  bottom: 0,

                ),
                child: Text('${date.hour}:${date.minute}',
                    style: const TextStyle(
                    fontSize: 10,
                   color: Colors.white,

                     ),

            ),
              ),
            ),
          ],
        ),

            ],

    );
  }
}
