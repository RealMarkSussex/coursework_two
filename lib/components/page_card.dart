import 'package:coursework_two/pages/exercises_page.dart';
import 'package:coursework_two/models/card_info_model.dart';
import 'package:flutter/material.dart';

class PageCard extends StatelessWidget {
  final CardInfoModel cardInfoModel;
  const PageCard({Key? key, required this.cardInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonFontSize = 18.0;
    const paragraphFontSize = 16.0;
    const titleFontSize = 20.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: Column(
        children: [
          Image(image: AssetImage('assets/images/${cardInfoModel.image}')),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                cardInfoModel.name,
                style: const TextStyle(fontSize: titleFontSize),
              ),
            ),
            subtitle: Text(
              cardInfoModel.description,
              style: const TextStyle(fontSize: paragraphFontSize),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                    onPressed: infoPage,
                    child: const Text(
                      "Info",
                      style: TextStyle(fontSize: buttonFontSize),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                    onPressed: () => {startPage(context)},
                    child: const Text(
                      "Start",
                      style: TextStyle(fontSize: buttonFontSize),
                    )),
              ),
            ],
          )
        ],
      )),
    );
  }

  void infoPage() {}

  void startPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ExercisesPage(exerciseType: cardInfoModel.name);
    }));
  }
}
