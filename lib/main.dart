import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursework_two/pages/about_page.dart';
import 'package:coursework_two/pages/home_page.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/exercise_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var exerciseState = ExerciseState(await getExercises());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SettingsState()),
    ChangeNotifierProvider(create: (context) => exerciseState)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Exercise app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/about': (context) => const AboutPage()
        });
  }
}

Future<List<ExerciseModel>> getExercises() async {
  CollectionReference _exercisesRef =
      FirebaseFirestore.instance.collection('exercises');
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _exercisesRef.orderBy('sequence').get();

  // Get data from docs and convert map to List
  return querySnapshot.docs
      .map((doc) => ExerciseModel.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
}
