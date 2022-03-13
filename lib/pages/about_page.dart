import 'package:coursework_two/models/about_model.dart';
import 'package:coursework_two/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textSpacing = 20.0;
    const nameSize = 20.0;
    const textSize = 18.0;
    return FutureBuilder<AboutModel>(
        future: FirebaseService().getAboutModel(),
        builder: (BuildContext context, AsyncSnapshot<AboutModel> snapshot) {
          var data = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: const Text('About'),
                backgroundColor: Colors.deepOrange,
                automaticallyImplyLeading: false,
              ),
              body: data != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InteractiveViewer(
                              panEnabled: false,
                              boundaryMargin: const EdgeInsets.all(100),
                              minScale: 0.5,
                              maxScale: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/${data.image}'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(26.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.solidUser,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(
                                    width: textSpacing,
                                  ),
                                  Flexible(
                                      child: Text(
                                    data.name,
                                    style: const TextStyle(fontSize: nameSize),
                                  ))
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(26.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.solidEnvelope,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(
                                    width: textSpacing,
                                  ),
                                  Flexible(
                                      child: Linkify(
                                    text: data.email,
                                    style: const TextStyle(fontSize: textSize),
                                  ))
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(26.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.graduationCap,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(
                                    width: textSpacing,
                                  ),
                                  Flexible(
                                      child: Linkify(
                                    text: data.studentId,
                                    style: const TextStyle(fontSize: textSize),
                                  ))
                                ]),
                          )
                        ])
                  : const SizedBox.shrink());
        });
  }
}
