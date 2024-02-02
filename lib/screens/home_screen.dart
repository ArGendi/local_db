import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_61/local/cache.dart';
import 'package:online_61/screens/login_screen.dart';
import 'package:online_61/screens/users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UsersScreen()));
            }, 
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: (){
              Cache.clearAll();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }, 
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          DateTime.now().hour < 14 ? 'Good morning,\n${Cache.getEmail()?.split("@")[0]}' : "Good evening, ${Cache.getEmail()?.split("@")[0]}",
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
    );
  }
}