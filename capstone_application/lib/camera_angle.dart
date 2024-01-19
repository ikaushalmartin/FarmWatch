import 'package:capstone/auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import '../const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import 'Services/notifi_service.dart';

class camera_angle extends StatefulWidget {
  const camera_angle({super.key});

  @override
  State<camera_angle> createState() => _camera_angleState();
}

class _camera_angleState extends State<camera_angle> {


  @override
  void initState() {
    super.initState();


  }

  int Up=0;
  int down=0;
  int left=0;
  int right=0;


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
                        "Camera Angle",
                        style: TextStyle(
                            fontFamily: 'semibold',
                            color: Color(0xff335F5E),
                            fontSize: 16),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:  EdgeInsets.only(

                      left: MediaQuery.of(context).size.width/20,right:MediaQuery.of(context).size.width/20,),
                    child: AspectRatio(
                      aspectRatio: 21/9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20),
                Padding(
                  padding:EdgeInsets.only(
                    left: MediaQuery.of(context).size.width/5,right:MediaQuery.of(context).size.width/5,),

                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/8,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Text("Up: $Up",style:   TextStyle(
                      fontFamily: 'semibold',
                      color: text,
                      fontSize: 14,
                    ),),
                           Text("Down: $down",style:   TextStyle(
                             fontFamily: 'semibold',
                             color: text,
                             fontSize: 14,
                           ),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Left: $left",style:   TextStyle(
                              fontFamily: 'semibold',
                              color: text,
                              fontSize: 14,
                            ),),
                            Text("Right: $right",style:   TextStyle(
                              fontFamily: 'semibold',
                              color: text,
                              fontSize: 14,
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10),
                Padding(
                  padding:EdgeInsets.only(
                    left: MediaQuery.of(context).size.width/5,right:MediaQuery.of(context).size.width/5,),

                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: ButtonTheme(
                              child: MaterialButton(
                                onPressed: () {setState(() {
                                  Up++;
                                });

                                },
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                minWidth: MediaQuery.of(context).size.width/8,
                                height: 52,
                                color: Color(0xff00A082),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white,size: 25,)
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ButtonTheme(
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      left++;
                                    });

                                  },
                                  elevation: 0,
                                  hoverElevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                  minWidth: MediaQuery.of(context).size.width/8,
                                  height: 52,
                                  color: Color(0xff00A082),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                    child: Icon(Icons.keyboard_arrow_left_rounded, color: Colors.white,size: 25,)
                                )),
                          ),
                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ButtonTheme(
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      right++;
                                    });

                                  },
                                  elevation: 0,
                                  hoverElevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                  minWidth: MediaQuery.of(context).size.width/8,
                                  height: 52,
                                  color: Color(0xff00A082),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                    child: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white,size: 25,)

                                )),
                          ),
                        ],),
                        Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: ButtonTheme(
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    down++;
                                  });

                                },
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                minWidth: MediaQuery.of(context).size.width/8,
                                height: 52,
                                color: Color(0xff00A082),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                  child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,size: 25,)

                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )

        ],
      ),));
  }
}
