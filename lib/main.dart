import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_61/local/cache.dart';
import 'package:online_61/providers/contacts_provider.dart';
import 'package:online_61/screens/add_contact.dart';
import 'package:online_61/screens/home_screen.dart';
import 'package:online_61/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Cache.init();
  await Hive.initFlutter();
  await Hive.openBox("accounts");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactsProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Cache.getEmail() != null ? HomeScreen() : LoginScreen(),
        home: AddContactScreen()
      ),
    );
  }
}