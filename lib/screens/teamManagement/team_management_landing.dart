import 'package:flutter/material.dart';

class TeamManagement extends StatefulWidget {
  const TeamManagement({ Key? key }) : super(key: key);

  @override
  State<TeamManagement> createState() => _TeamManagementState();
}

class _TeamManagementState extends State<TeamManagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Teams"),
    );
  }
}