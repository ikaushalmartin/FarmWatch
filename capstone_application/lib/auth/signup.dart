import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'email_verification.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final fullname_controller = TextEditingController();
  final phone_controller = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
                  "Create an account",
                  style: TextStyle(
                      fontFamily: 'Medium',
                      color: Color(0xffffffff),
                      fontSize: 16),
                ),

                Text(
                  "Sign up now and start exploring all that our app has to offer. We’re excited to welcome you to our community.",
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
                child: Form(
                  key: formkey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(

                            bottom: MediaQuery.of(context).size.height / 50),
                        child: const Text(
                          "Signup",
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
                          onChanged: (value) {},
                          controller: fullname_controller,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(320),
                          ],cursorColor: Color(0xff01A082),
                          enableInteractiveSelection: false,
                          style: const TextStyle(color: Color(0xff01A082)),
                          textAlign: TextAlign.left,
                          decoration: kTextFieldDecoration.copyWith(
                              contentPadding: const EdgeInsets.only(left: 20),
                              hintText: "Full Name", hintStyle: TextStyle(color: Color(0xffB5B6BC),  fontSize: 14)),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color(0xffF5F6FA),
                        ),
                        child: TextFormField(
                          onChanged: (value) {},
controller: phone_controller,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(320),
                          ],cursorColor: Color(0xff01A082),
                          enableInteractiveSelection: false,
                          style: const TextStyle(color: Color(0xff01A082)),
                          textAlign: TextAlign.left,
                          decoration: kTextFieldDecoration.copyWith(
                              contentPadding: const EdgeInsets.only(left: 20),
                              hintText: "Phone", hintStyle: TextStyle(color: Color(0xffB5B6BC),  fontSize: 14)),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color(0xffF5F6FA),
                        ),
                        child: TextFormField(
                          onChanged: (value) {},
controller: email_controller,
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
controller: password_controller,
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

                                  signup();
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
                                  "signup",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "medium"),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height /60),
                      Text(
                        "By Signing in you will agree to our Terms and conditions and Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'regular',
                            color:Color(0xff0A3732),
                            fontSize: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 17.5,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    ));
  }

  Future signup() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim()).then((value){
        var emailsnackbar = SnackBar(
          content: const Text("Account created successfully, Proceed with Email Verification"),
          backgroundColor:Color(0xff335F5E),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
          duration: Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
        );
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(emailsnackbar);
        });
        adduserdata(fullname_controller.text.trim(), phone_controller.text.trim(), email_controller.text.trim());
        Get.to(() => email_verification(),
            transition: Transition.rightToLeft);

      });

    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        var emailsnackbar = SnackBar(
          content: const Text("Email already in use!"),
          backgroundColor:Color(0xff335F5E),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
          duration: Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
        );
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(emailsnackbar);
        });
        Navigator.of(context).pop();
        return;
      } else if (e.code == "weak-password") {
        var passwordsnackbar = SnackBar(
          content: const Text("Weak password! Use strong password"),
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
          duration: Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
        );
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(passwordsnackbar);
        });
        Navigator.of(context).pop();
        return;
      } else {
        print(e.code);
        var othersnackbar = SnackBar(
          content: Text("${e.code}"),
          backgroundColor: Color(0xff335F5E),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
          duration: Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
        );
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(othersnackbar);
        });
        Navigator.of(context).pop();
        return;
      }
    }
  }

  Future adduserdata(
      String name,
      String phone,
      String email,
      ) async {

    await FirebaseFirestore.instance.collection("users").doc(email).set({
      'full name': name,
      'phone': phone,
      'email': email,

    });
  }

}
