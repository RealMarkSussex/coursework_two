import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

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
    await _consentsRef
        .doc(auth.currentUser?.uid)
        .set({'consented': consented, 'consentType': consentType});
  }

  Future<void> addSetForUser() async {
    CollectionReference _setsDoneRef =
        FirebaseFirestore.instance.collection('setsDone');
    FirebaseAuth auth = FirebaseAuth.instance;

    await _setsDoneRef
        .doc(const Uuid().v1().toString())
        .set({'uid': auth.currentUser?.uid, 'date': DateTime.now()});
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
