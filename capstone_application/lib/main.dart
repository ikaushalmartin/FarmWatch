import 'package:capstone/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/email_verification.dart';
import 'auth/login_screen.dart';

import 'dashboard.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'capstone',
    options: DefaultFirebaseOptions.currentPlatform,
  );

 FirebaseMessaging.onBackgroundMessage( handleBackgroundMessage);
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {

    return CircularProgressIndicator();
    } else if (snapshot.hasData && snapshot.data != null) {




    if ( snapshot.data!.emailVerified) {

    return const dashboard();
    } else {

    return const email_verification();
    }
    } else {

    return const onboarding();



    }
    },
    ));




  }
}




class onboarding extends StatefulWidget {
  const onboarding({super.key});


  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0A3732),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 80.0)),
              child: const Image(
                image: AssetImage(
                    'images/onboard.jpg'),

              ),
            ),
            Column(
              children: [
                Padding(
                  padding:EdgeInsets.only(top: MediaQuery.of(context).size.height / 16),
                  child: Text(
                    "Defend Against Stray",
                    style: TextStyle(
                        fontFamily: 'semibold',
                        color: Color(0xffffffff),
                        fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40,top: MediaQuery.of(context).size.height / 140,left:MediaQuery.of(context).size.width / 40,right:MediaQuery.of(context).size.width / 40 ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Guard your farm with vigilant surveillance\nand quick intrusion response",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'medium',
                          color: Color(0xffA7D7CB),
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(

                  left: MediaQuery.of(context).size.height / 30,
                  right: MediaQuery.of(context).size.height / 30,
                  bottom: MediaQuery.of(context).size.height / 40,
                ),
                child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: ButtonTheme(
                        child: MaterialButton(
                          onPressed: () {
                            Get.to(login(),transition: Transition.rightToLeft);
                          },
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          minWidth: MediaQuery.of(context).size.width,
                          height: 52,
                          color: Color(0xff00A082),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: "medium"),
                          ),
                        )))),

          ],
        ),

      ),
    );
  }
}
