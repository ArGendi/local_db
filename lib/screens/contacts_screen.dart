import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_61/cubits/contacts_cubit.dart';
import 'package:online_61/cubits/contacts_state.dart';
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
    //Provider.of<ContactsProvider>(context, listen: false).getContacts(); --> Provider
    BlocProvider.of<ContactsCubit>(context).getContacts();
  }

  @override
  Widget build(BuildContext context) {
    var contactsCubit = BlocProvider.of<ContactsCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            if(state is LoadingState){
              return Center(child: CircularProgressIndicator());
            }
            else if(state is GetDataState){
              return Center(
                child: Icon(Icons.check_circle, color: Colors.green, size: 50,),
              );
            }
            else if(state is SuccessState){
              return ListView.separated(
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Text(contactsCubit.contacts[i].name.toString()),
                      Text(contactsCubit.contacts[i].phone.toString()),
                    ],
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: contactsCubit.contacts.length,
              );
            }
            else{
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red,),
                  Text(
                    'Try again later',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ));
            }
          },
        ),
        // child: Consumer<ContactsProvider>(
        //   builder: (context, provider, _){
        //     return ListView.separated(
        //       itemBuilder: (context, i){
        //         return Column(
        //           children: [
        //             Text(provider.contacts[i].name.toString()),
        //             Text(provider.contacts[i].phone.toString()),
        //           ],
        //         );
        //       },
        //       separatorBuilder: (context, i){
        //         return SizedBox(height: 10,);
        //       },
        //       itemCount: provider.contacts.length,
        //     );
        //   }
        // ),
      ),
    );
  }
}
