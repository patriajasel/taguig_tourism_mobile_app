import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/widgets/widget_generator.dart';

class UserSettingsTab extends StatefulWidget {
  const UserSettingsTab({super.key});

  @override
  State<UserSettingsTab> createState() => _UserSettingsTabState();
}

class _UserSettingsTabState extends State<UserSettingsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          children: [
            const SizedBox(height: 65),
            Container(
              child: GenerateWidget().generateElevatedButton(
                  'Notification', // Text of the button
                  Colors.blueAccent.shade700, // Background Color
                  Colors.white,
                  notifButton),
            ),
            const SizedBox(height: 35),
            Container(
              child: GenerateWidget().generateElevatedButton(
                  'Language', // Text of the button
                  Colors.blueAccent.shade700, // Background Color
                  Colors.white, // Text Color
                  languageButton),
            ),
            const SizedBox(height: 35),
            Container(
              child: GenerateWidget().generateElevatedButton(
                  'Help and Support', // Text of the button
                  Colors.blueAccent.shade700, // Background Color
                  Colors.white,
                  helpSuppButton // Text Color
                  ),
            ),
            const SizedBox(height: 35),
            Container(
              child: GenerateWidget().generateElevatedButton(
                  'Send Feedback', // Text of the button
                  Colors.blueAccent.shade700, // Background Color
                  Colors.white, // Text Color
                  sendFeedbackButton),
            ),
            const SizedBox(height: 35),
            Container(
              child: GenerateWidget().generateElevatedButton(
                  'Log out', // Text of the button
                  Colors.blueAccent.shade700, // Background Color
                  Colors.white, // Text Color
                  logOutButton),
            ),
          ],
        ),
      ),
    );
  }

  void notifButton() {}

  void languageButton() {}

  void helpSuppButton() {}

  void sendFeedbackButton() {}

  void logOutButton() {}
}
