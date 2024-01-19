import 'dart:convert';
 
recent_intrusion recent_intrusionFromJson(String str) => recent_intrusion.fromJson(json.decode(str));

String recent_intrusionToJson(recent_intrusion data) => json.encode(data.toJson());

class recent_intrusion {
  recent_intrusion(
      {required this.name,
        required this.date,
        required this.time,
        required this.image_url
      });

  String name;
  String date;
  String time;
  String image_url;

  factory recent_intrusion.fromJson(Map<String, dynamic> json) => recent_intrusion(

      name: json['Name'],
      date: json['Date'],
      time: json['Time'],
      image_url: json['image_url']
  );

  Map<String, dynamic> toJson() => {
    'Name':name,
    'Date':date,
    'Time':time,
    'image_url':image_url

  };
}
