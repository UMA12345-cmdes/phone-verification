import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/screen/get_otp.dart';

class SignPhone extends StatefulWidget {
  const SignPhone({Key? key}) : super(key: key);

  @override
  State<SignPhone> createState() => _SignPhoneState();
}

class _SignPhoneState extends State<SignPhone> {
TextEditingController phonecontroller =  TextEditingController();

void sendOtp() async {
  String phone = "+91" + phonecontroller.text.trim();
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phone,
    codeSent: (verificationId, resendToken){
      Navigator.push(context, MaterialPageRoute(builder: (context) => GetOtp(verificationId: verificationId,
      )
       ));
    },

   verificationCompleted: (credential){},
    verificationFailed: (ex){log(ex.code.toString());
    },
    
      codeAutoRetrievalTimeout: (verificationId){},
      timeout: const Duration(seconds: 30),
      );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign in with phone'),
      ),
      body: SafeArea(child: ListView(
        children: [
          Padding(padding: 
          const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: phonecontroller,
                decoration: const InputDecoration(
                  labelText: 'phone number',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20,),

              MaterialButton(onPressed: (){
                sendOtp();
              },
              color: Colors.blue,
              child: const Text('Sign In',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          )
        ],
        
      )),
    );
  }
}