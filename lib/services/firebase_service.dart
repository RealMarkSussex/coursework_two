import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../enums/level.dart';
import '../models/about_model.dart';
import '../models/card_info_model.dart';
import '../models/credit_model.dart';
import '../models/exercise_model.dart';
import '../models/set_model.dart';

class FirebaseService {
  Future<List<ExerciseModel>> getExercises() async {
    CollectionReference _exercisesRef =
        FirebaseFirestore.instance.collection('exercises');
    QuerySnapshot querySnapshot = await _exercisesRef.orderBy('sequence').get();

    return querySnapshot.docs
        .map(
            (doc) => ExerciseModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<AboutModel> getAboutModel() async {
    CollectionReference _appInformationRef =
        FirebaseFirestore.instance.collection('app_information');
    DocumentSnapshot documentSnapshot =
        await _appInformationRef.doc('about').get();

    return AboutModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<List<CreditModel>> getCredits() async {
    CollectionReference _creditsRef =
        FirebaseFirestore.instance.collection('credits');
    QuerySnapshot querySnapshot = await _creditsRef.get();

    return querySnapshot.docs
        .map((doc) => CreditModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<CardInfoModel>> getCardInfoModel() async {
    CollectionReference _cardInfoRef =
        FirebaseFirestore.instance.collection('cardInfo');
    QuerySnapshot querySnapshot = await _cardInfoRef.get();

    return querySnapshot.docs
        .map(
            (doc) => CardInfoModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateExercise(
      Map<String, String> formData, String document) async {
    CollectionReference _exercisesRef =
        FirebaseFirestore.instance.collection('exercises');
    await _exercisesRef.doc(document).update({
      'process': formData['process'],
      'precaution': formData['precaution'],
      'benefits': formData['benefits'],
      'breathing': formData['breathing'],
      'audio': formData['audio'],
      'image': formData['image'],
    });
  }

  Future<void> storeConsentForUser(bool consented, String consentType) async {
    CollectionReference _consentsRef =
        FirebaseFirestore.instance.collection('consents');
    FirebaseAuth auth = FirebaseAuth.instance;
    await _consentsRef.doc(auth.currentUser?.uid).set({'consented': consented});
  }

  Future<void> storeLevelForUser(Level level) async {
    CollectionReference _levelsRef =
        FirebaseFirestore.instance.collection('levels');
    FirebaseAuth auth = FirebaseAuth.instance;
    await _levelsRef
        .doc(auth.currentUser?.uid)
        .set({'level': level.toModel().description});
  }

  Future<Level?> getLevelForUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    DocumentSnapshot _levelRef = await FirebaseFirestore.instance
        .collection('levels')
        .doc(auth.currentUser?.uid)
        .get();
    if (_levelRef.exists) {
      var data = _levelRef.data()! as Map<String, dynamic>;
      return Level.newToYoga
          .toList()
          .firstWhere(
              (element) => element.description == (data["level"] as String))
          .level;
    }

    return null;
  }

  Future<bool?> getConsentForUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    DocumentSnapshot _consentRef = await FirebaseFirestore.instance
        .collection('consents')
        .doc(auth.currentUser?.uid)
        .get();

    if (_consentRef.exists) {
      var data = _consentRef.data()! as Map<String, dynamic>;
      return data["consented"] as bool;
    }
    return null;
  }

  Future<void> addSetForUser() async {
    CollectionReference _setsDoneRef =
        FirebaseFirestore.instance.collection('setsDone');
    FirebaseAuth auth = FirebaseAuth.instance;
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String? uid = auth.currentUser?.uid;
    QuerySnapshot querySnapshot = await _setsDoneRef.get();

    var doc = querySnapshot.docs.where((element) {
      var data = element.data()! as Map<String, dynamic>;
      return data["date"].toDate() == date && data["uid"] as String == uid;
    });

    if (doc.isNotEmpty) {
      var numberOfSets =
          (doc.first.data()! as Map<String, dynamic>)["numberOfSets"] as int;
      await _setsDoneRef
          .doc(doc.first.id)
          .set({'uid': uid, 'date': date, 'numberOfSets': numberOfSets + 1});
    } else {
      await _setsDoneRef
          .doc(const Uuid().v1().toString())
          .set({'uid': uid, 'date': date, 'numberOfSets': 1});
    }
  }

  Future<List<SetModel>> getSetsForUser() async {
    CollectionReference _setsDoneRef =
        FirebaseFirestore.instance.collection('setsDone');
    FirebaseAuth auth = FirebaseAuth.instance;

    QuerySnapshot querySnapshot =
        await _setsDoneRef.where('uid', isEqualTo: auth.currentUser?.uid).get();

    return querySnapshot.docs
        .map((doc) => SetModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
