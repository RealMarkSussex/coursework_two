import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/exercise_state.dart';

class EditExercisePage extends StatefulWidget {
  const EditExercisePage({Key? key}) : super(key: key);

  @override
  State<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  final _formKey = GlobalKey<FormState>();
  static const spacing = 20.0;
  String document = "";
  final Map<String, dynamic> _editExerciseForm = <String, String>{
    'process': '',
    'precaution': '',
    'benefits': '',
    'breathing': '',
    'audio': '',
    'image': ''
  };

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var exerciseModel = Provider.of<ExerciseState>(context, listen: false)
          .currentExerciseModel;
      setState(() {
        document = exerciseModel.name;
        _editExerciseForm['process'] = exerciseModel.process;
        _editExerciseForm['precaution'] = exerciseModel.precaution;
        _editExerciseForm['benefits'] = exerciseModel.benefits;
        _editExerciseForm['breathing'] = exerciseModel.breathing;
        _editExerciseForm['audio'] = exerciseModel.audio;
        _editExerciseForm['image'] = exerciseModel.image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("Edit exercise", context),
      body: Consumer<ExerciseState>(builder: (context, exerciseState, child) {
        var exerciseModel = exerciseState.currentExerciseModel;
        return SizedBox(
          height: 700,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    initialValue: exerciseModel.process,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'process'),
                    validator: (value) {
                      return textValidator(value);
                    },
                    onChanged: (value) => onTextChange(value, 'process'),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  TextFormField(
                    initialValue: exerciseModel.precaution,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'precaution'),
                    validator: (value) {
                      return textValidator(value);
                    },
                    onChanged: (value) => onTextChange(value, 'precaution'),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  TextFormField(
                    initialValue: exerciseModel.benefits,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'benefits'),
                    validator: (value) {
                      return textValidator(value);
                    },
                    onChanged: (value) => onTextChange(value, 'benefits'),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: exerciseModel.breathing,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'breathing'),
                      validator: (value) {
                        return textValidator(value);
                      },
                      onChanged: (value) => onTextChange(value, 'breathing'),
                    ),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: exerciseModel.audio,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'audio file'),
                      validator: (value) {
                        return textValidator(value);
                      },
                      onChanged: (value) => onTextChange(value, 'audio'),
                    ),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: exerciseModel.image,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'image file'),
                      validator: (value) {
                        return textValidator(value);
                      },
                      onChanged: (value) => onTextChange(value, 'image'),
                    ),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  Flexible(
                      child: ElevatedButton(
                          onPressed: submitForm, child: const Text("Submit")))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }

    return null;
  }

  void onTextChange(String value, String key) {
    _editExerciseForm[key] = value;
  }

  Future<void> submitForm() async {
    CollectionReference exercises =
        FirebaseFirestore.instance.collection('exercises');
    if (_formKey.currentState!.validate()) {
      await exercises
          .doc(document)
          .update({'process': _editExerciseForm['process']});
      Navigator.pop(context);
    }
  }
}
