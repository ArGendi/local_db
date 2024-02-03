import 'package:flutter/material.dart';
import 'package:online_61/local/my_database.dart';
import 'package:online_61/models/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];

  void getData() async{
    MyDatabase myDB = MyDatabase();
    List<Contact> tempContacts = await myDB.getContacts();
    setState(() {
      contacts = tempContacts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, i){
            return Column(
              children: [
                Text(contacts[i].name.toString()),
                Text(contacts[i].phone.toString()),
              ],
            );
          }, 
          separatorBuilder: (context, i){
            return SizedBox(height: 10,);
          }, 
          itemCount: contacts.length,
        ),
      ),
    );
  }
}