import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_61/local/cache.dart';
import 'package:online_61/local/my_database.dart';
import 'package:online_61/models/contact.dart';
import 'package:online_61/screens/contacts_screen.dart';
import 'package:online_61/screens/home_screen.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  Contact contact = Contact();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsScreen()));
            }, 
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onSaved: (value){
                  contact.name = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'name',
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                keyboardType: TextInputType.phone,
                onSaved: (value){
                  contact.phone = value;
                },
                decoration: InputDecoration(
                  labelText: 'Phone'
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () async{
                  formKey.currentState!.save();
                  MyDatabase myDB = MyDatabase();
                  myDB.insert(contact);
                  formKey.currentState!.reset();
                }, 
                child: Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}