class SetModel {
  final String uid;
  final DateTime date;

  SetModel({required this.uid, required this.date});

  SetModel.fromJson(Map<String, Object?> json)
      : this(uid: json['uid']! as String, date: json['date']! as DateTime);
}
