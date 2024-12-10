import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';
import 'package:taguig_tourism_mobile_app/util/constants/sizes.dart';

class FeedbackPage extends StatefulWidget {
  final String uid;
  const FeedbackPage({super.key, required this.uid});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController feedback = TextEditingController();

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        'GoTaguig App Feedback',
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.shade700,
              Colors.redAccent.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.01),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Text('We want your feedback!',
                    style: TextStyle(
                        fontSize: Sizes.fontSizeLg,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: screenHeight * 0.78,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          feedbackFormField(
                              'Name', 1, 'Your Full Name', fullname),
                          feedbackFormField('Email', 1, 'Your Email', email),
                          feedbackFormField(
                              'Contact', 1, 'Your Phone Number', contact),
                          feedbackFormField(
                              'Feedback',
                              12,
                              'Write your feedback from our app here',
                              feedback),
                          Row(
                            children: [
                              Expanded(
                                  child: OutlinedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.01974),
                                      ),
                                      onPressed: () async {
                                        await FirestoreServices()
                                            .sendFeedback(
                                          widget.uid,
                                          fullname.text,
                                          email.text,
                                          contact.text,
                                          feedback.text,
                                        )
                                            .then(
                                          (value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Thank you for sending feedback, this will be reviewed by our team.')),
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
                                      )))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  feedbackFormField(name, maxLine, hintText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueAccent.shade700,
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: controller,
              maxLines: maxLine,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blueAccent.shade700,
                )),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
