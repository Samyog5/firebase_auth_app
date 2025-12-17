import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/main.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  String verificationid;
  OtpScreen({super.key, required this.verificationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('OTP Screen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpcontroller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter the OTP',
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24)
                )
              ),
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: ()async{
            try{
              PhoneAuthCredential credential =  await PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpcontroller.text.toString());
              FirebaseAuth.instance.signInWithCredential(credential).then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: 'Welcome Back')));

              });
            }catch(ex){
              log(ex.toString());
            }
            }, child: Text('Verify OTP'))
        ],
      ),
    );
  }
}