import 'package:flutter/material.dart';
import 'package:foodie/screens/forgot_password.dart';
import 'package:foodie/screens/register.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../firebase/firebase_auth.dart';
import 'home_screen.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void Login() async {
      debugPrint("email : " + _emailController.text.toString());
      debugPrint("passwrod : " + _passwordController.text.toString());
      bool loginSuccess = await AuthManager().loginUser(
          _emailController.text.toString(),
          _passwordController.text.toString());
      if (loginSuccess) {
        debugPrint("login successful");
        Get.to(
            HomeScreen(),
            transition: Transition.leftToRightWithFade,
            duration: const Duration(milliseconds: 400));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Invalid email or password.'),
                actions: [
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });

      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox (
              height : 100,
            ),
            Container(
              height: 25.75,


              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login.png')


                ),
              ),
            ),
            SizedBox (
              height : 60,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 30),
              child: Text(
                'Sign In into your Account ',
                style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
            Container(

                padding: EdgeInsets.only(top: 60,
                    right: 30,
                    left: 30),
                child: Column(
                    children:[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                          ),

                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sign In', style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w700,
                            color: Colors.orange.shade800,
                          ),),
                          GestureDetector(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.orange.shade800,
                              child: Icon(Icons.arrow_forward, color: Colors.white,),
                            ),
                            onTap: () {
                              Login();
                            },
                          )

                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed:() {
                            Get.to(
                                MyRegister(),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(milliseconds: 400));
                          },
                              child: Text('Sign Up', style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.orange.shade800,
                            fontSize: 18,
                          ))),
                          TextButton(onPressed:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                          }, child: Text('Forget Password',
                              style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.orange.shade800,
                            fontSize: 18,
                          )))
                        ],
                      )

                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}
