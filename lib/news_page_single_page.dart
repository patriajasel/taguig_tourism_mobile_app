import 'package:flutter/material.dart';

class SingleNewsPage extends StatefulWidget {
  const SingleNewsPage({super.key});

  @override
  State<SingleNewsPage> createState() => _SingleNewsPageState();
}

class _SingleNewsPageState extends State<SingleNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        foregroundColor: Colors.white, // Set back button color to white
      ),
      body: Stack(
        children: [
          // Background Image that covers the AppBar
          Positioned(
            top: 0, // Start from the top
            left: 0,
            right: 0,
            child: SizedBox(
              height:
                  260, // Set the height of the image container (adjust as needed)
              child: Image.asset(
                'lib/assets/images/taguig_image1.png',
                fit: BoxFit.cover, // Ensure the image covers the container
              ),
            ),
          ),
          // Card Content
          Positioned(
            top:
                200, // Adjust this value to position the card below the AppBar and background image
            left: 0,
            right: 0,
            bottom: 0, // Adjust bottom to give space for the button
            child: Card(
              color: Colors.white, // Make the card slightly transparent
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title aligned to the left
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Text(
                            maxLines: 2,
                            'A Very Long Text',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Address row with icon
                        Container(
                          margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.schedule, color: Colors.blue),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '6 hours ago',
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
                        // Scrollable Description with Carousel
                        Expanded(
                          child: SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ut ornare nisi. Suspendisse ullamcorper diam quis elementum auctor. Vivamus pellentesque lacinia elit, vitae consequat eros iaculis vel. Curabitur pharetra orci dolor, et mollis nulla venenatis id. Fusce est lorem, auctor at elit consequat, mollis lacinia neque. Fusce rutrum quam eget nulla dapibus, aliquet pretium nisl consequat. Pellentesque id tristique enim. Vivamus massa justo, porta nec pulvinar a, sodales vel purus. Nunc at pellentesque lacus. Suspendisse interdum sit amet elit nec pharetra. Nunc quis semper nibh. Maecenas dapibus sagittis nisi quis consectetur. Sed gravida nibh non velit mollis, eget posuere tellus tempus. Quisque sodales elit a leo laoreet hendrerit. Pellentesque eu commodo velit. Nullam finibus dictum elit, id pellentesque est iaculis ac. Sed sit amet venenatis felis. In tempor viverra ex sit amet fringilla. Sed non ante lorem. Integer eu interdum augue. Morbi laoreet ligula et mauris vulputate, quis tempus metus sodales. Nam pharetra leo ac rhoncus consectetur. Donec at dui dolor. Phasellus tellus sem, malesuada sit amet rhoncus eget, porttitor vel diam. Phasellus purus ligula, semper eu tempor a, blandit et enim. Donec feugiat mi in lorem ullamcorper, sit amet dignissim sem ultricies.',
                                    textAlign: TextAlign
                                        .justify, // Changed from left to justify
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.facebook,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                        Icon(
                                          Icons.language,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Button positioned at the bottom
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
