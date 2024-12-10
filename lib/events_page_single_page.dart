import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taguig_tourism_mobile_app/models/events.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';

class SingleEventPage extends StatefulWidget {
  final Events event;
  const SingleEventPage({super.key, required this.event});

  @override
  State<SingleEventPage> createState() => _SingleEventPageState();
}

class _SingleEventPageState extends State<SingleEventPage> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImageUrl(); // Call the helper function
  }

  Future<void> _loadImageUrl() async {
    try {
      String url =
          await FirestoreServices().getImageUrl(widget.event.imageDirectory);
      setState(() {
        imageUrl = url;
      });
    } catch (error) {
      print("Error fetching image URL: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.event.eventDate);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 260,
              child: imageUrl == null
                  ? Center(
                      child: CircularProgressIndicator()) // Loading indicator
                  : Image.network(
                      imageUrl!, // Correct usage without quotes
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text("Cannot load image"));
                      },
                    ),
            ),
          ),
          // Card Content
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Title
                    Container(
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        widget.event.eventName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Event Date
                    Container(
                      margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, color: Colors.blue),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              DateFormat('MMMM dd, yyyy')
                                  .format(widget.event.eventDate.toDate()),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    // Event Description
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.eventDescription,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.facebook,
                                      size: 40, color: Colors.blue),
                                  SizedBox(width: 20),
                                  Icon(Icons.language,
                                      size: 40, color: Colors.blue),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
