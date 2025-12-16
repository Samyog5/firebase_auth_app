import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_series/ui_helper.dart';

class SIgnupPage extends StatefulWidget {
  const SIgnupPage({super.key});

  @override
  State<SIgnupPage> createState() => _SIgnupPageState();
}

class _SIgnupPageState extends State<SIgnupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async{
    if(email == '' && password == ''){
      UiHelper.CustomAlertBox(context, 'Please Enter Email and Password First');
    }else{
      UserCredential? userCredential;
      try{
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((onValue) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'HomePage')));
        });
      }on FirebaseAuthException catch(ex){
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, 'Email', Icons.mail, false),
          UiHelper.CustomTextField(passwordController, 'Password', Icons.password, true),
          SizedBox(height: 30,),
          UiHelper.CustomButton((){
            signUp(emailController.text.toString(), passwordController.text.toString());},
            'Sign Up')

        ],

      ),
    );
  }
}