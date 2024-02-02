import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_61/local/cache.dart';
import 'package:online_61/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onSaved: (value){
                  email = value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter your email";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                onSaved: (value){
                  password = value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter your password";
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () async{
                  bool valid = formKey.currentState!.validate();
                  if(valid){
                    formKey.currentState!.save();
                    print(email);
                    print(password);
                    await Cache.saveEmail(email.toString());
                    /// insert with Hive
                    Box box = Hive.box("accounts");
                    int key = await box.add({
                      'email': email,
                      'password': password,
                    });
                    print("key: $key");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                }, 
                child: Text("login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}