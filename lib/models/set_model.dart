import 'package:cloud_firestore/cloud_firestore.dart';

class SetModel {
  final String uid;
  final DateTime date;
  final int numberOfSets;

  SetModel({required this.uid, required this.date, required this.numberOfSets});

  SetModel.fromJson(Map<String, Object?> json)
      : this(
            uid: json['uid']! as String,
            date: (json['date'] as Timestamp).toDate(),
            numberOfSets: json["numberOfSets"] as int);
}
