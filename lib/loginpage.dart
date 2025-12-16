import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/forgotpassword.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/signuppage.dart';
import 'package:firebase_series/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async{
    if(email.isEmpty && password.isEmpty){
      return UiHelper.CustomAlertBox(context, 'Please Enter the required fields');
    }else{
      UserCredential? userCredential;
      try{
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Welcome Back'),),),);
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(passwordController, 'Password', Icons.password, true),
          SizedBox(height: 30,),
          UiHelper.CustomButton((){
            login(emailController.text.toString(), passwordController.text.toString());
          }, 'Login'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have account?', style: TextStyle(fontSize: 15),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SIgnupPage()));
              }, child: Text('Sign Up',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),))
            ],
          ),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
          }, child: Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold),) )
        ],

      ),
    );
  }
}