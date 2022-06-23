import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/screen/sign_phone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 void logOut() async{
  await FirebaseAuth.instance.signOut();
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignPhone()));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home '),
        actions: [
          IconButton(onPressed: (){
            logOut();
          }, icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body:  SafeArea(child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
children: [
  Text('Welcome to your page', style: TextStyle(fontSize: 17),),
  Text('You are successfully SignIn With Phone',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), ),
],
           ),
          ),
        ),
      )),
    );
  }
}