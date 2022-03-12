import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar('Comments', context),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Expanded(
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: commentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter a comment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Flexible(
                  child: ElevatedButton(
                      onPressed: submitForm, child: const Text("Submit")))
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sending email')),
      );

      final Email email = Email(
        body: commentController.text,
        subject: emailController.text,
        recipients: ['marksussex6@gmail.com'],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}
