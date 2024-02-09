import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_61/local/my_database.dart';
import 'package:online_61/models/contact.dart';

class ContactsProvider extends ChangeNotifier{
  List<Contact> contacts = [];

  void getContacts() async{
    // MyDatabase myDB = MyDatabase();
    // contacts = await myDB.getContacts();
    if(contacts.isEmpty){
      print("Getting contacts from DB");
      contacts = await MyDatabase().getContacts();
      notifyListeners();
    }
  }

  void addContact(BuildContext context, Contact contact)async{
    // bool saved = await MyDatabase().insert(contact);
    // if(saved){
    //   contacts.add(contact);
    //   notifyListeners();
    // }
    // else{
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Error, We don't add it... "), backgroundColor: Colors.red,)
    //   );
    // }

    // right solution
    MyDatabase().insert(contact).then((value){
      if(value){
        contacts.add(contact);
        notifyListeners();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error, We don't add it... "), backgroundColor: Colors.red,)
        );
      }
    });
  }
}