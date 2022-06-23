import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/screen/homescreen.dart';

class GetOtp extends StatefulWidget {
  final String verificationId;
  const GetOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<GetOtp> createState() => _GetOtpState();
}

class _GetOtpState extends State<GetOtp> {
TextEditingController otpcontroller = TextEditingController();

void verifyOtp() async {
 String otp = otpcontroller.text.trim();

        PhoneAuthCredential credential =
         PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
         smsCode: otp);
         try{

        UserCredential usercredential = await 
        FirebaseAuth.instance.signInWithCredential
        (credential);
         if(usercredential.user != null){
Navigator.popUntil(context, (route) => route.isFirst);
Navigator.pushReplacement(context, MaterialPageRoute(
  builder: (context) => const HomeScreen()
  ));         
         }
         }
         on FirebaseAuthException catch(ex){
          log(ex.code.toString());
         }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verified otp'),
        centerTitle: true,
      ),
      body: SafeArea(child: ListView(
        children: [
          Padding(padding: 
          const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: otpcontroller,
                decoration: const InputDecoration(
                  labelText: '6-digit otp',
                  counterText: ""
                  
                ),
              ),
              const SizedBox(height: 20,),

              MaterialButton(onPressed: (){
                verifyOtp();
              },
              color: Colors.blue,
              child: const Text('Verify otp'),
              ),
            ],
          ),
          )
        ],
        
      )),
    );
  }
}