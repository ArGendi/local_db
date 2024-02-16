import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_61/cubits/contacts_state.dart';
import 'package:online_61/local/my_database.dart';
import 'package:online_61/models/contact.dart';

class ContactsCubit extends Cubit<ContactsState>{
  List<Contact> contacts = [];
  
  ContactsCubit() : super(InitContactState());

  void getContacts() async{
    try{
      emit(LoadingState());
      await Future.delayed(Duration(seconds: 2));
      contacts = await MyDatabase().getContacts();
      emit(GetDataState());
      await Future.delayed(Duration(seconds: 2));
      emit(SuccessState());
    }
    catch(e){
      emit(FailState());
    }
  }

  void addContact(BuildContext context, Contact contact)async{
    emit(LoadingState());
    await Future.delayed(Duration(seconds: 2));
    MyDatabase().insert(contact).then((value){
      if(value){
        contacts.add(contact);
        emit(InsertContactState());
      }
      else{
        emit(FailState());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error, We don't add it... "), backgroundColor: Colors.red,)
        );
      }
    });
  }
}