import 'package:capstone/auth/reset_pass.dart';
import 'package:capstone/auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../const.dart';
import '../dashboard.dart';
import 'email_verification.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final email_for_login_controller = TextEditingController();
  final password_for_login_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          User user = snapshot.data!;
          if (user.emailVerified) {
            return dashboard();
          } else {
            return email_verification();
          }
        } else {
          return  SafeArea(child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/2.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 80.0)),
                      child:  Container(color:Color(0xff0A3732),)
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/50, left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Farm Watch",
                        style: TextStyle(
                            fontFamily: 'semibold',
                            color: Color(0xffffffff),
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 200),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontFamily: 'Medium',
                            color: Color(0xffffffff),
                            fontSize: 16),
                      ),

                      Text(
                        "We’re excited to have you back, can’t wait to see what you’ve been up to since you last logged in.",
                        style: TextStyle(
                            fontFamily: 'regular',
                            color: Color(0xffffffff),
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/4.5,
                    left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(
                              20)),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 30,
                          blurRadius: 100,
                          // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/60,
                        left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40,
                      ),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(

                                bottom: MediaQuery.of(context).size.height / 50),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: 'semibold',
                                  color: Color(0xff0A3732),
                                  fontSize: 14),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xffF5F6FA),
                            ),
                            child: TextFormField(
                              controller: email_for_login_controller,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(320),
                              ],cursorColor: Color(0xff01A082),
                              enableInteractiveSelection: false,
                              style: const TextStyle(color: Color(0xff01A082)),
                              textAlign: TextAlign.left,
                              decoration: kTextFieldDecoration.copyWith(
                                  contentPadding: const EdgeInsets.only(left: 20),
                                  hintText: "Email", hintStyle: TextStyle(color: Color(0xffB5B6BC),  fontSize: 14)),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 80),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF5F6FA),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (value) {},
                              controller: password_for_login_controller,
                              inputFormatters: [

                              ],cursorColor: Color(0xff01A082),
                              enableInteractiveSelection: false,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Color(0xff01A082)),
                              textAlign: TextAlign.left,
                              decoration: kTextFieldDecoration.copyWith(
                                  contentPadding: const EdgeInsets.only(left: 20),
                                  hintText: "Password", hintStyle: TextStyle(color: Color(0xffB5B6BC), fontSize: 14)),
                              validator: (phone) => phone != null && phone.length < 6
                                  ? "Password Can't empty or less than 6"
                                  : null,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 80),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Theme(
                              data: ThemeData(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(const resetpassword(),transition: Transition.rightToLeft);
                                },
                                child: const Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                    fontFamily: 'semibold',
                                    fontSize: 12,
                                    color: Color(0xff0A3732),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 30,
                                bottom: MediaQuery.of(context).size.height / 60),
                            child: Theme(
                              data: ThemeData(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: ButtonTheme(
                                  child: MaterialButton(
                                    onPressed: () {
                                      login_user();

                                    },
                                    elevation: 0,
                                    hoverElevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    minWidth: MediaQuery.of(context).size.width,
                                    height: 52,
                                    color: Color(0xff00A082),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child: const Text(
                                      "LogIn",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: "medium"),
                                    ),
                                  )),
                            ),
                          ),
                          Center(
                            child: Text(
                              "LogIn with Google",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff00A082),
                                  fontFamily: "semibold"),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height /60),
                          Text(
                            "By Logging in you will agree to our Terms and conditions and Privacy Policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'regular',
                                color:Color(0xff0A3732),
                                fontSize: 10),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 17.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "New to Farm Watch? ",
                                style: TextStyle(
                                    fontFamily: 'medium',
                                    color: Color(0xff0A3732),
                                    fontSize: 14),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Theme(
                                  data: ThemeData(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(signup(),transition: Transition.rightToLeft);

                                    },
                                    child: const Text(
                                      "SignUp!",
                                      style: TextStyle(
                                        fontFamily: 'semibold',
                                        fontSize: 14,
                                        color: Color(0xff00A082),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ));
        }
      },
    );
  }
  Future login_user() async{


    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_for_login_controller.text.trim(),
          password: password_for_login_controller.text.trim()).then((value){

      });
    } on FirebaseAuthException catch (e) {
      print("---->${e.code}");
      var othersnackbar = SnackBar(
        content: Text("${e.code}"),
        backgroundColor: const Color(0xff335F5E),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(othersnackbar);
      });

      Navigator.of(context).pop();
      return;
    }

    Navigator.of(context).pop();

  }
}


