import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursework_two/components/page_card.dart';
import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:coursework_two/models/card_info_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardInfoModel>>(
        future: getCardInfoModel(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CardInfoModel>> snapshot) {
          var data = snapshot.data;
          data ??= [];
          return Scaffold(
              appBar: createAppBar('Sun Salutatons', context),
              body: Center(
                  child: ListView(
                scrollDirection: Axis.vertical,
                children: data.map((e) => PageCard(cardInfoModel: e)).toList(),
              )));
        });
  }

  Future<List<CardInfoModel>> getCardInfoModel() async {
    CollectionReference _cardInfoRef =
        FirebaseFirestore.instance.collection('cardInfo');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _cardInfoRef.get();

    // Get data from docs and convert map to List
    return querySnapshot.docs
        .map(
            (doc) => CardInfoModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
