import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../firebase/firebase_auth.dart';
import 'home_screen.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void SignUp () async {
      debugPrint( _emailController.text.toString());
      bool loginSuccess = await AuthManager().registerUser(_emailController.text.toString(), _passwordController.text.toString());
      if (loginSuccess) {
        // Navigate to the home page
        Get.to(
            HomeScreen(),
            transition: Transition.leftToRightWithFade,
            duration: const Duration(milliseconds: 400));

      } else {
        // Show login error message
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
            }
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.orange.shade800,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox (
              height : 40,
            ),


            Container(
              height: 25.75,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Register.png'),


                ),
              ),
            ),
            SizedBox (
              height : 40,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 30),
              child: Text(
                'Sign Up for the FoodHub',
                style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
            Container(

                padding: EdgeInsets.only(top: 40,
                    right: 30,
                    left: 30),
                child: Column(
                    children:[
                      TextField(

                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                        height: 20,
                      ),
                      TextField(
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
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sign Up', style: TextStyle(
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
                              SignUp();
                            },
                          )

                        ],
                      ),

                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}
