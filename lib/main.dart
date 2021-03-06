import 'package:coursework_two/pages/about_page.dart';
import 'package:coursework_two/pages/comment_page.dart';
import 'package:coursework_two/pages/credits_page.dart';
import 'package:coursework_two/pages/edit_exercise_page.dart';
import 'package:coursework_two/pages/home_page.dart';
import 'package:coursework_two/pages/statistics_page.dart';
import 'package:coursework_two/services/firebase_service.dart';
import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/opacity_state.dart';
import 'package:coursework_two/state/page_state.dart';
import 'package:coursework_two/state/progress_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.signInAnonymously();

  var exerciseState = ExerciseState(await FirebaseService().getExercises());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SettingsState()),
    ChangeNotifierProvider(create: (context) => exerciseState),
    ChangeNotifierProvider(create: (context) => ProgressState()),
    ChangeNotifierProvider(create: (context) => AudioState()),
    ChangeNotifierProvider(create: (context) => PageState()),
    ChangeNotifierProvider(create: (context) => OpacityState()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'Exercise app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/about': (context) => const AboutPage(),
          '/comment': (context) => const CommentPage(),
          '/credits': (context) => const CreditsPage(),
          '/editExercise': (context) => const EditExercisePage(),
          '/statistics': (context) => const StatisticsPage()
        });
  }
}
