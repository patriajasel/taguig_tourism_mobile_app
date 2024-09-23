import 'package:flutter/material.dart';
import 'widgets/widget_generator.dart';


class UserProfileTab extends StatefulWidget {
  const UserProfileTab({super.key});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 421,
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GenerateWidget().generateTitleField('Personal Information')
                ),
              ],
            ),
            
            const SizedBox(
              height: 15,
            ),
            
            Row(
              children: [
                GenerateWidget().generatedProfileTextField("First Name Last Name"),
              ],
            ),
            
            const SizedBox(
              height: 10,
            ),
      
            Row(
              children: [
                Expanded(child: GenerateWidget().generatedProfileTextField("Gender"),),
      
                const SizedBox(
                  width: 10,
                ),
      
                Expanded(child: GenerateWidget().generatedProfileTextField("01/01/2001"),),
              ],
            ),
            
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GenerateWidget().generateTitleField('E-mail and Password'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // GenerateWidget().generateProfileTextField("Email", email),
                  Row(
                    children: [
                      GenerateWidget().generatedProfileTextField("Username@gmail.com"),
                    ]
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GenerateWidget().generatedProfileTextField("Password"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GenerateWidget().generateElevatedButton('Save', const Color.fromARGB(255, 33, 86, 243), Colors.white, saveButton)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void saveButton (){

  }
}