import 'dart:convert';
import 'package:capstone/text_class.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:capstone/auth/signup.dart';
import 'package:capstone/models/recent_intrusions.dart';
import 'package:capstone/recent%20intrusion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import '../const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:translator_plus/translator_plus.dart';
import '../profile.dart';
import 'Services/notifi_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:translator_plus/translator_plus.dart';




class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var ip="192.168.57.71";
  final translator = GoogleTranslator();
  String hello_test="Hello Martin!";
  String second_top="Welcome to Farm Watch";
  String todaysweather="Todays Weather";
  String recentintrusion="Recent Intrusions";
  String test_notification="Test Notification";
  String stop_buzzer="Stop Buzzer";
  var livefarmview="Live Farm View";

  @override
  void initState() {
    super.initState();
    fetch_weather();
    fetch_recent_intrusion();



  }

  @override
  void dispose() {

    super.dispose();}

  List<recent_intrusion> recent_intrusion_list=[];
  DateTime now = DateTime.now();

  // Format the date to get the day and date

  String location="Fetching Location..";
  double temp=0;
  String weather_type="";
  double min_temp=0;
  double max_temp=0;


  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    String formattedDate = DateFormat('EEEE, d MMMM').format(now);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/4.2,
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 80.0)),
                child:  Container(color:Color(0xff0A3732),)
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/60, left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      hello_test,
                      style: TextStyle(
                          fontFamily: 'semibold',
                          color: Color(0xffffffff),
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      second_top,
                      style: TextStyle(
                          fontFamily: 'Medium',
                          color: Color(0xffffffff),
                          fontSize: 10),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: (){
                      translate_text();
                    },
                    child: Icon(Icons.translate_outlined, color: Colors.white,))
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/9, left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40 ),
            child: Text(
              todaysweather,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "semibold"),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/6.8,
              left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(
                        20)),

              ),
              child: Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/70,
                  left:MediaQuery.of(context).size.height/70,right: MediaQuery.of(context).size.height/70,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff5CB4E2),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left:12.0,top: 16,bottom: 16,right: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "semibold"),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "medium"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(

                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$temp°C",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: "semibold"),
                                ),
                                Text(
                                  weather_type,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "medium"),
                                ),
                              ],
                            ),
                            Column(

                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Min $min_temp°C",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "medium"),
                                ),
                                Text(
                                  "Max $max_temp°C",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "medium"),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),


                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/2.7, left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40 ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recentintrusion,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0A3732),
                      fontFamily: "semibold"),
                ),
                GestureDetector(
                    onTap: (){
                      Get.to(()=>Recent_Intrusion(),transition: Transition.rightToLeft);
                    },
                    child: Icon(Icons.more_horiz,size: 22, color: Color(0xff0A3732),))
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/2.46, left:MediaQuery.of(context).size.height/40,right: MediaQuery.of(context).size.height/40, ),
            child:Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: recent_intrusion_list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:  (){

                        showDialog(
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
                          },);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage("${recent_intrusion_list[index].image_url}"),
                              radius: 35,
                            ),
                            Text(
                              "${recent_intrusion_list[index].name}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff0A3732),
                                  fontFamily: "medium"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

              ),
            ),
          ),
         Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 1.75,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:  EdgeInsets.only( left: MediaQuery.of(context).size.width/20,right:MediaQuery.of(context).size.width/20,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: ButtonTheme(
                          child: MaterialButton(
                            onPressed: () async {

                                final String apiUrl = 'http://$ip:8000/test_notification';

                                try {
                                  // Make a GET request to the API
                                  final response = await http.get(Uri.parse(apiUrl));

                                  // Check if the request was successful (status code 200)
                                  if (response.statusCode == 200) {
                                    // Successful response, you can process the data here
                                    final snackBar = SnackBar(
                                      content: Text('${response.body}'),
                                      duration: Duration(seconds: 3), // Adjust the duration as needed
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Handle undo action if needed
                                          print('Undo action pressed');
                                        },
                                      ),
                                    );

                                    // Use the ScaffoldMessenger to show the SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text('${response.statusCode}'),
                                      duration: Duration(seconds: 3), // Adjust the duration as needed
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Handle undo action if needed
                                          print('Undo action pressed');
                                        },
                                      ),
                                    );

                                    // Use the ScaffoldMessenger to show the SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                  }
                                } catch (error) {
                                  // Handle network or other errors here
                                  print('Error: $error');
                                }


                            },
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            minWidth: MediaQuery.of(context).size.width/2.5,
                            height:MediaQuery.of(context).size.height/4,
                            color: Color(0xff00A082),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child:  Text(
                              test_notification,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "semibold"),
                            ),
                          )),
                    ),
                    Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: ButtonTheme(
                          child: MaterialButton(
                            onPressed: () async {
                              final String apiUrl = 'http://$ip:8000/stop_buzzer';

                              try {
                                // Make a GET request to the API
                                final response = await http.get(Uri.parse(apiUrl));

                                // Check if the request was successful (status code 200)
                                if (response.statusCode == 200) {
                                  // Successful response, you can process the data here
                                  final snackBar = SnackBar(
                                    content: Text('${response.body}'),
                                    duration: Duration(seconds: 3), // Adjust the duration as needed
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Handle undo action if needed
                                        print('Undo action pressed');
                                      },
                                    ),
                                  );

                                  // Use the ScaffoldMessenger to show the SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                } else {
                                  final snackBar = SnackBar(
                                    content: Text('${response.statusCode}'),
                                    duration: Duration(seconds: 3), // Adjust the duration as needed
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Handle undo action if needed
                                        print('Undo action pressed');
                                      },
                                    ),
                                  );

                                  // Use the ScaffoldMessenger to show the SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }
                              } catch (error) {
                                // Handle network or other errors here
                                print('Error: $error');
                              }

                            },
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            minWidth: MediaQuery.of(context).size.width/2.5,
                            height:MediaQuery.of(context).size.height/4,
                            color: Color(0xff00A082),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child:  Text(
                              stop_buzzer,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "semibold"),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height/1.24,
              left:MediaQuery.of(context).size.height/25,right: MediaQuery.of(context).size.height/25,

            ),
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ButtonTheme(
                  child: MaterialButton(
                    onPressed: () {
                      FlutterWebBrowser.openWebPage(
                        url: "http://${ip}:8000/camera_stream",

                      );
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
                    child:  Text(
                      "$livefarmview",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: "semibold"),
                    ),
                  )),
            ),
          ),
        ],
      ),
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 25.0,
          selectedColor: Color(0xff01A082),
          strokeColor: Color(0xffffffff),
          elevation: 1,

          opacity: 0,
          unSelectedColor: Color(0xffB9B8BE),
          backgroundColor: Colors.white,
          items: [
            CustomNavigationBarItem(
              icon: Icon(MdiIcons.home, ),
              title: Text("Home", style: TextStyle(fontSize: 8,   fontFamily: 'regular'),),
            ),
            CustomNavigationBarItem(
              icon: Icon(MdiIcons.account,  ),
              title: Text("Profile", style: TextStyle(fontSize: 8,   fontFamily: 'regular')),
            ),

          ],
          currentIndex: _currentIndex,
          onTap: (index) {

            if(index==0){
              Get.offAll(()=>  dashboard(),
                  transition: Transition.noTransition);
            }
            else if(index==1){
              Get.to(profile(), transition: Transition.noTransition);

            }
          },
        )
    ));
  }

  Future<void> fetch_recent_intrusion() async {
  var recent_intrusion=await FirebaseFirestore.instance.collection("Previous Intrusion").get();
  map_recent_intrusion(recent_intrusion);
  }

  map_recent_intrusion(QuerySnapshot<Map<String,dynamic>> data) async{
   var recent_intrusion_items=data.docs.map((item)=>recent_intrusion(name: item['Name'], date: item['Date'], time: item['Time'], image_url:item['image_url'])).toList();
   for (int i = 0; i < recent_intrusion_items.length && i < 4; i++) {
     recent_intrusion_list.add(recent_intrusion_items[i]);
   }
   setState(() {
     recent_intrusion_list;
   });
   print(recent_intrusion_list);


  }

  Future<void> fetch_weather() async{
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': '30.3398',
      'lon': '76.3869',
      'units': 'metric',
      'appid': '146e1a9b7b8e8c17dc924f61b27f9318'
    });

    var response =await http.get(url);

    if(response.statusCode==200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      location=jsonResponse["name"];
      temp=jsonResponse["main"]["temp"];
      weather_type=jsonResponse["weather"][0]["description"];
      min_temp=jsonResponse["main"]["temp_min"];
      max_temp=jsonResponse["main"]["temp_max"];

    }


    setState(() {

      temp;weather_type;min_temp;max_temp;location;
    });

  }

  translate_text(){


    translator.translate(hello_test, from: 'en', to: 'hi').then((Translation translation) {

        hello_test = translation.text;

    });

    translator.translate(second_top, from: 'en', to: 'hi').then((Translation translation) {

        second_top = translation.text;

    });

    translator.translate(todaysweather, from: 'en', to: 'hi').then((Translation translation) {

        todaysweather = translation.text;});


      translator.translate(test_notification, from: 'en', to: 'hi').then((Translation translation) {

        test_notification = translation.text;

      });

      translator.translate(stop_buzzer, from: 'en', to: 'hi').then((Translation translation) {

        stop_buzzer = translation.text;
      });

      translator.translate(livefarmview, from: 'en', to: 'hi').then((Translation translation) {

        livefarmview = translation.text;

    });translator.translate(recentintrusion, from: 'en', to: 'hi').then((Translation translation) {

      recentintrusion = translation.text;

    });

      setState(() {
        hello_test;test_notification;
        livefarmview;stop_buzzer;
        todaysweather;second_top;
        recentintrusion;
      });

      for(int i=0;i<recent_intrusion_list.length;i++){
        translator.translate(recent_intrusion_list[i].name, from: 'en', to: 'hi').then((Translation translation) {

          recent_intrusion_list[i].name = translation.text;

        });
      }

  }

}
