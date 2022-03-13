import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/about_model.dart';
import '../models/card_info_model.dart';
import '../models/credit_model.dart';
import '../models/exercise_model.dart';

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
    CollectionReference exercises =
        FirebaseFirestore.instance.collection('exercises');
    await exercises.doc(document).update({
      'process': formData['process'],
      'precaution': formData['precaution'],
      'benefits': formData['benefits'],
      'breathing': formData['breathing'],
      'audio': formData['audio'],
      'image': formData['image'],
    });
  }
}
