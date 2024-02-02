import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:online_61/models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> users = [];

  void getUsers(){
    Box box = Hive.box("accounts");
     List<User> tempUsers = [];
    for(var key in box.keys.toList()){ // [0,1,2]
      Map data = box.get(key);
      tempUsers.add(
        User(data['email'], data['password'])
      );
    }
    setState(() {
      users = tempUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, i){
            return Text("${users[i].email} | ${users[i].password}");
          }, 
          separatorBuilder: (context, i){
            return SizedBox(height: 10,);
          }, 
          itemCount: users.length,
        ),
      ),
    );
  }
}