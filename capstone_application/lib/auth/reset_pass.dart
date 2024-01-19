import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../const.dart';

class resetpassword extends StatefulWidget {
  const resetpassword({Key? key}) : super(key: key);

  @override
  State<resetpassword> createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  Color textcolor = Color(0xff1A1D44);
  Color bluecolor = Color(0xff014CC4);
  Color textcolor_white = Color(0xffACAEBA);
  Color white = Color(0xffffffff);
  Color background = Color(0xffF1F1F1);

  final resetemailcontroller = TextEditingController();

  final GlobalKey<FormState> _navigatorKey = GlobalKey<FormState>();
  @override
  void dispose() {
    resetemailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF6F6F6),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 20,
              right: MediaQuery.of(context).size.width / 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
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
                    "Reset Password",
                    style: TextStyle(
                        fontFamily: 'Medium',
                        color: Color(0xff335F5E),
                        fontSize: 16),
                  ),
                ),
                const Text(
                  "Enter your email address and we'll send you a link for resetting your password.",
                  style: TextStyle(
                      fontFamily: 'regular',
                      color: Color(0xff335F5E),
                      fontSize: 10),
                ),
                Expanded(
                  child: Form(
                    key: _navigatorKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 12,
                              bottom: MediaQuery.of(context).size.height / 80),
                          child: Text(
                            "Email?",
                            style: TextStyle(
                                fontFamily: 'semibold',
                                color: Colors.black87,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextFormField(
                            onChanged: (value) {},
                            enableInteractiveSelection: false,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(350),
                            ],cursorColor:Color(0xff335F5E),
                            controller: resetemailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: textcolor),
                            textAlign: TextAlign.left,
                            decoration: kTextFieldDecoration.copyWith(
                                contentPadding: EdgeInsets.only(left: 20),
                                hintText: "Registered Email"),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,

                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 40),
                        Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: ButtonTheme(
                              child: MaterialButton(
                                onPressed: () {
                                  if (_navigatorKey.currentState!.validate()) {
                                    resetpasswordfunc();
                                  }
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
                                  "Send Reset Email",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "medium"),
                                ),
                              )),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 60),
                        const Text(
                          "Check spam folder too, If not able to find the mail",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'regular',
                              color: Color(0xff335F5E),
                              fontSize: 10),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future resetpasswordfunc() async {



    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetemailcontroller.text.trim());

      var ssnackbar = SnackBar(
        content: Text("Password reset mail sent successfully!"),
        backgroundColor: textcolor,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
        duration: Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(ssnackbar);
      });
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      var rsnackbar = SnackBar(
        content: Text("${e.code}"),
        backgroundColor: textcolor,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
        duration: Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(rsnackbar);
      });
      Navigator.of(context).pop();
      return;
    }
  }
}
