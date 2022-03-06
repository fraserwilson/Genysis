import 'package:flutter/material.dart';
import 'package:genysis/screens/chatApplication/chat_details.dart';

class ConversationsList extends StatefulWidget {
  String? name;
  String? messageText;
  String? imageUrl;
  String? time;
  bool? isMessageRead;
  ConversationsList(
      {this.name,
      this.messageText,
      this.imageUrl,
      this.time,
      this.isMessageRead});

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage();
        }));
      },
      child: Container(
        padding: EdgeInsets.only(
            left: width * 0.016, right: width * 0.016, top: height * 0.01),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl!),
                    maxRadius: height * 0.03,
                  ),
                  SizedBox(
                    width: width * 0.016,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name!,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            widget.messageText!,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead!
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time!,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead!
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
