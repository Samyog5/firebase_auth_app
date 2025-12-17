import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/otpscreen.dart';
import 'package:flutter/material.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('Continue with phone number'),
              backgroundColor: Colors.blueAccent,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number',
                        suffixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: ()async{
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted: (PhoneAuthCredential credential){}, 
                      verificationFailed: (FirebaseAuthException ex){}, 
                      codeSent: (String verificationid, int? resendtoken){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpScreen(verificationid: verificationid,)));
                      }, 
                      codeAutoRetrievalTimeout: (String verificationId){}, 
                      phoneNumber: phoneController.text.toString()
                    );
                    
                  }, child: Text('Verify Phone Number'))
                ],
              ),
            ),
          );
  }
}