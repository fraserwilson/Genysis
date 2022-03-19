import 'package:flutter/material.dart';

class PlayerManagement extends StatefulWidget {
  const PlayerManagement({ Key? key }) : super(key: key);

  @override
  State<PlayerManagement> createState() => _PlayerManagementState();
}

class _PlayerManagementState extends State<PlayerManagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Player"),
    );
  }
}