import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../dashboard.dart';
import 'login_screen.dart';



class email_verification extends StatefulWidget {
  const email_verification({super.key});

  @override
  State<email_verification> createState() => _email_verificationState();
}

class _email_verificationState extends State<email_verification> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  initState(){
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendverification();
      timer =
          Timer.periodic(Duration(seconds: 3), (_) => checkEmailverification());
    }
  }

  Future checkEmailverification() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }


  Future sendverification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      var verify = SnackBar(
        content: Text("$e"),
        backgroundColor:Color(0xff335F5E),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
        duration: Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(verify);
      });
    }
  }
  Widget build(BuildContext context) => isEmailVerified ?  dashboard():SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF6F6F6),
        body: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 20,
            right: MediaQuery.of(context).size.width / 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prakriti",
                          style: TextStyle(
                              fontFamily: 'semibold',
                              color: Color(0xff335F5E),
                              fontSize: 20),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              fontFamily: 'medium',
                              color: Color(0xff335F5E),
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 50,
                        bottom: MediaQuery.of(context).size.height / 200),
                    child: Text(
                      "Email Verification",
                      style: TextStyle(
                          fontFamily: 'Medium',
                          color: Color(0xff335F5E),
                          fontSize: 16),
                    ),
                  ),
                  const Text(
                    "We have sent you verification link on your email, verify you account by visiting that link.",
                    style: TextStyle(
                        fontFamily: 'regular',
                        color: Color(0xff335F5E),
                        fontSize: 10),
                  ),
                ],
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
                          FirebaseAuth.instance.signOut();
                          Get.offAll(const login(),transition: Transition.leftToRight);

                        },
                        elevation: 0,
                        hoverElevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        minWidth: MediaQuery.of(context).size.width,
                        height: 52,
                        color: Color(0xff335F5E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "medium"),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ));
}
