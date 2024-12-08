import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support', // Title for the page
          style: TextStyle(color: Colors.white), // Title color set to white
        ),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
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
        iconTheme: IconThemeData(
          color: Colors.white, // Back button color set to white
        ),
      ),
      backgroundColor:
          Colors.white.withOpacity(0.9), // Subtle white background with opacity
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Header section
            const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Welcome to the Help & Support page of Taguig On The Go App. We're here to assist you with any questions or concerns. Below, you'll find information on common topics and how to get further help.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // FAQs section
            const Text(
              'Frequently Asked Questions (FAQs)',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Account & Login section
            buildSectionTitle('Account & Login'),
            buildFAQItem(
              'How do I create an account?',
              'Go to the sign-up page, enter your email, set a password, and follow the prompts.',
            ),
            buildFAQItem(
              'I forgot my password. What should I do?',
              'Click "Forgot Password" on the login page, and we’ll send you an email with instructions to reset it.',
            ),
            buildFAQItem(
              'Can I update my profile information?',
              'Yes! Navigate to the "Profile" section in the app settings to edit your details.',
            ),

            const SizedBox(height: 20),

            // Location’s Contact section
            buildSectionTitle('Location’s Contact'),
            buildFAQItem(
              'How do I book or reserve a Hotel room?',
              'Browse through destinations, select your desired Hotel, and tap the link attached in the location. Book or reserve through their website.',
            ),
            buildFAQItem(
              'How can I contact the Management of the Location?',
              'Select a Location you want to contact with, and in the Location’s info, there is contact information for their location (Website link or Contact Number).',
            ),

            const SizedBox(height: 20),

            // App Features section
            buildSectionTitle('App Features'),
            buildFAQItem(
              'How can I save my favorite destinations?',
              'Tap the heart icon on any destination to add it to your "Favorites."',
            ),
            buildFAQItem(
              'Can I see the weather for my upcoming Trip?',
              'Absolutely! Go to the Weather Page for weather forecasts. Our weather page can forecast for today and for the next 5 days.',
            ),
            buildFAQItem(
              'How can I go to my Destination?',
              'Go to the Commute Guide and look for your destination (From “Location” to “Destination”) and follow the steps given, or go to Terminals on the Home page to manually look for Terminals in Taguig.',
            ),
            buildFAQItem(
              'Can I ask someone in the App?',
              'There is a chatbot that can help assist you regarding the app and location info.',
            ),

            const SizedBox(height: 20),

            // Troubleshooting section
            buildSectionTitle('Troubleshooting'),
            buildFAQItem(
              'The app is crashing or not loading properly.',
              '• Ensure you have the latest version of the app installed.\n• Clear the app cache or restart your device.\n• If the issue persists, contact support.',
            ),
            buildFAQItem(
              'The app isn’t syncing properly.',
              '• Ensure you have a stable internet connection.\n• Log out and log back into your account.\n• Contact support if the issue remains.',
            ),

            const SizedBox(height: 20),

            // Contact Us section
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "If you couldn’t find the answer you’re looking for, feel free to contact us. We’re here to help!",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              "• Email: [Provide Email]\n• Phone: [Provide Phone Number]\n• Feedback: Share your thoughts in the \"Feedback\" section of the app.",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Final thank you message
            const Text(
              "Thank you for choosing Taguig On The Go App. Safe travels!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              answer,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
