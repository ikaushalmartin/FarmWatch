import 'package:capstone/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import '../const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import '../main.dart';
import 'Services/notifi_service.dart';
import 'camera_angle.dart';
import 'home_page.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Color text=Color(0xff0A3732);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 80,
              left: MediaQuery.of(context).size.height / 80,
              right: MediaQuery.of(context).size.height / 80,
              bottom: MediaQuery.of(context).size.height / 80,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell (
                        onTap: (){
                          Get.back();
                        },
                        splashColor: Colors.black,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: text,
                            size: 20,
                          ),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width / 40),
                    const Text(
                      "Profile",
                      style: TextStyle(
                          fontFamily: 'semibold',
                          color: Color(0xff335F5E),
                          fontSize: 16),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: ()async{




                    FirebaseAuth.instance.signOut();


                    var othersnackbar = SnackBar(
                      content: Text("Logged out successfully!"),
                      backgroundColor: Color(0xff335F5E),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                      duration: Duration(milliseconds: 2000),
                      behavior: SnackBarBehavior.floating,
                    );
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(othersnackbar);

                    });

                    Get.offAll(()=>const onboarding(), transition: Transition.leftToRight);



                  },
                  child: Icon(
                    Icons.logout_rounded,
                    color: text,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 80,
                  left: MediaQuery.of(context).size.height / 60,
                  right: MediaQuery.of(context).size.height / 60,

                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height / 60,
                    right: MediaQuery.of(context).size.height / 60,
                    bottom: MediaQuery.of(context).size.height / 60,
                    top: MediaQuery.of(context).size.height / 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius:30,
                              backgroundColor: text,
                              child: Icon(MdiIcons.account,size: 30,color: Colors.white,)),
                          SizedBox(width: MediaQuery.of(context).size.width/20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                "Martin Kaushal",
                                style:   TextStyle(
                                  fontFamily: 'semibold',
                                  color: text,
                                  fontSize: 14,
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height/300),
                              Text(
                                "email_add_your",
                                style: TextStyle(
                                    fontFamily: 'medium',
                                    color: text,
                                    fontSize: 10),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/300),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/100),
                      Text(
                        "Hey We are developing this platform for farmers",
                        style:  TextStyle(
                            fontFamily: 'Medium',
                            color: text,
                            fontSize: 10),

                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 80,
                  left: MediaQuery.of(context).size.height / 60,
                  right: MediaQuery.of(context).size.height / 60,

                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 60,
                        right: MediaQuery.of(context).size.height / 60,
                        bottom: MediaQuery.of(context).size.height / 60,
                        top: MediaQuery.of(context).size.height / 60,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Camera Angle",
                            style: TextStyle(
                              fontFamily: 'semibold',
                              color: text,
                              fontSize: 14,
                            ),),

                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ButtonTheme(
                                child: MaterialButton(
                                    onPressed: () {
                                      Get.to(()=>camera_angle(), transition: Transition.rightToLeft);

                                    },
                                    elevation: 0,
                                    hoverElevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    minWidth: 30,
                                    height: 40,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child:Icon(Icons.arrow_forward_ios_outlined,color: text,size: 18,)
                                )),
                          ),

                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 80,
                  left: MediaQuery.of(context).size.height / 60,
                  right: MediaQuery.of(context).size.height / 60,

                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 60,
                        right: MediaQuery.of(context).size.height / 60,
                        bottom: MediaQuery.of(context).size.height / 60,
                        top: MediaQuery.of(context).size.height / 60,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Alert Sound",
                            style: TextStyle(
                              fontFamily: 'semibold',
                              color: text,
                              fontSize: 14,
                            ),),

                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ButtonTheme(
                                child: MaterialButton(
                                    onPressed: () {

                                    },
                                    elevation: 0,
                                    hoverElevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    minWidth: 30,
                                    height: 40,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    child:Icon(Icons.phonelink_ring_outlined,color: text,size: 18,)
                                )),
                          ),

                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 80,
                  left: MediaQuery.of(context).size.height / 60,
                  right: MediaQuery.of(context).size.height / 60,

                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height / 60,
                      right: MediaQuery.of(context).size.height / 60,
                      bottom: MediaQuery.of(context).size.height / 60,
                      top: MediaQuery.of(context).size.height / 60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sample Notification",
                         style: TextStyle(
                            fontFamily: 'semibold',
                            color: text,
                            fontSize: 14,
                          ),),

                        Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: ButtonTheme(
                              child: MaterialButton(
                                onPressed: () {
                                  NotificationService()
                                      .showNotification(title: 'Sample', body: 'It works!');

                                },
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                minWidth: 30,
                                height: 40,
                                color: text,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Text(
                                  "     Test     ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "medium"),
                                ),
                              )),
                        ),

                      ],
                    )
                  ),
                ),
              ),


            ],
          ),
        )

      ],
    ),));
  }
}
