import 'package:flutter/material.dart';
import 'package:genysis/screens/chatApplication/chat_app.dart';
import 'package:genysis/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("GENYSIS"),
        elevation: 0.0,
        actions: [
          TextButton.icon(onPressed: () async {
            await _auth.signOut();
          }, 
          icon: Icon(Icons.person,color: Colors.white,), 
          label: Text("Logout", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: ChatAppPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Channels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}