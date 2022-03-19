import 'package:flutter/material.dart';
import 'package:genysis/services/auth.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final screens = [
    Center(child: Text("Chats", style: TextStyle(fontSize: 60),),),
    Center(child: Text("Team", style: TextStyle(fontSize: 60),),),
    Center(child: Text("Player", style: TextStyle(fontSize: 60),),)
  ];
  int currentIndex = 0;
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