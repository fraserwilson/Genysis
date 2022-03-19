import 'package:flutter/material.dart';
import 'package:genysis/screens/playerManagement/player_management_landing.dart';
import 'package:genysis/screens/teamManagement/team_management_landing.dart';
import 'package:genysis/services/auth.dart';
import '../chat_app/chat_landing.dart';



class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final screens = [
    Center(child: ChatLandingPage()),
    Center(child: TeamManagement()),
    Center(child: PlayerManagement())
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        selectedFontSize: 12,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Team Management",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Player Management",
          ),
        ],
      ),
    );
  }
}