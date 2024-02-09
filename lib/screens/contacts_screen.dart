import 'package:flutter/material.dart';
import 'package:online_61/local/my_database.dart';
import 'package:online_61/models/contact.dart';
import 'package:online_61/providers/contacts_provider.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ContactsProvider>(context, listen: false).getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ContactsProvider>(
          builder: (context, provider, _){
            return ListView.separated(
              itemBuilder: (context, i){
                return Column(
                  children: [
                    Text(provider.contacts[i].name.toString()),
                    Text(provider.contacts[i].phone.toString()),
                  ],
                );
              }, 
              separatorBuilder: (context, i){
                return SizedBox(height: 10,);
              }, 
              itemCount: provider.contacts.length,
            );
          }
        ),
      ),
    );
  }
}