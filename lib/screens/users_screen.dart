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
      User newUser = User.fromMap(data);
      newUser.key = key;
      tempUsers.add(newUser);
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
            return Row(
              children: [
                Text("${users[i].email} | ${users[i].password}"),
                Spacer(),
                IconButton(
                  onPressed: (){
                    Box box = Hive.box("accounts");
                    box.put(users[i].key, {
                      "email": "mohamed@gmail.com",
                      "password": users[i].password,
                    });
                    setState(() {
                      users[i].email = "mohamed@gmail.com";
                    });
                  }, 
                  icon: Icon(Icons.update,),
                ),
                IconButton(
                  onPressed: (){
                    Box box = Hive.box("accounts");
                    box.delete(users[i].key);
                    setState(() {
                      users.removeAt(i);
                    });
                  }, 
                  icon: Icon(Icons.delete, color: Colors.red,),
                ),
              ],
            );
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