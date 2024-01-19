import 'package:capstone/auth/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import '../const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import 'Services/notifi_service.dart';
import 'camera_angle.dart';
import 'models/recent_intrusions.dart';

class Recent_Intrusion extends StatefulWidget {
  const Recent_Intrusion({super.key});

  @override
  State<Recent_Intrusion> createState() => _Recent_IntrusionState();
}

class _Recent_IntrusionState extends State<Recent_Intrusion> {
  Color text=Color(0xff0A3732);

  List<recent_intrusion> recent_intrusion_list=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_recent_intrusion();
  }
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
                        "Recent Intrusion",
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
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: recent_intrusion_list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("${recent_intrusion_list[index].name}",),
                          content: Column(
                            children: [
                              Text('A ${recent_intrusion_list[index].name} has been identified on Camera No. 1 at ${recent_intrusion_list[index].time}, on ${recent_intrusion_list[index].date}.'),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                                child: Image.network(recent_intrusion_list[index].image_url),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },);},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 80,
                          left: MediaQuery.of(context).size.height / 60,
                          right:
                          MediaQuery.of(context).size.height / 60,
                          bottom:
                          MediaQuery.of(context).size.height / 80,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap:(){
                      },
                              child: CircleAvatar(
                                radius: 30,
                                foregroundImage: NetworkImage(
                                    "${recent_intrusion_list[index].image_url}"
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${recent_intrusion_list[index].name}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'medium',
                                    fontSize: 16,
                                    color: text,
                                  ),
                                ),
                                Text(
                                  "${recent_intrusion_list[index].time} ${recent_intrusion_list[index].date}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'medium',
                                    fontSize: 14,
                                    color: text,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

            ),
          ),


        ],
      ),));
  }

  Future<void> fetch_recent_intrusion() async {
    var recent_intrusion=await FirebaseFirestore.instance.collection("Previous Intrusion").get();
    map_recent_intrusion(recent_intrusion);
  }

  map_recent_intrusion(QuerySnapshot<Map<String,dynamic>> data) async{
    var recent_intrusion_items=data.docs.map((item)=>recent_intrusion(name: item['Name'], date: item['Date'], time: item['Time'], image_url:item['image_url'])).toList();

      recent_intrusion_list=recent_intrusion_items;

    setState(() {
      recent_intrusion_list;
    });


  }
}
