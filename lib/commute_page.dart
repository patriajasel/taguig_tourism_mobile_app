import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';

void main() => runApp(const CommutePage());

class CommutePage extends StatefulWidget {
  const CommutePage({super.key});

  @override
  State<CommutePage> createState() => _CommutePageState();
}

class _CommutePageState extends State<CommutePage> {
  List<String> baranggayList = [
    "South Daang Hari",
    "Bagumbayan",
    "Tanyag",
    "North Daang Hari",
    "New Lower",
    "Lower & Central Bicutan",
    "Napindan",
    "Ibayo Tipas",
    "Ligid Tipas",
    "Palingon Tipas",
    "Calzada Tipas",
    "Sta. Ana",
    "Wawa",
    "Tuktukan",
    "Bambang",
    "San Miguel",
    "Ususan",
    "Katuparan",
    "Hagonoy",
    "Half of North Signal",
    "Half North",
    "Pinagsama",
    "Central Signal",
    "South Signal",
    "Upper Bicutan",
    "Maharlika",
    "Western Bicutan",
    "Fort Bonifacio"
  ];

  List<String> destinationList = [
    "Bonifacio Global City",
    "Bonifacio High Street",
    "Market Market",
    "The Mind Museum",
    "Venice Grand Canal Mall",
    "The Heritage Park",
    "Memorial Philippine Army Museum",
    "Manila American Cemetery",
    "St. Anne Parish Church"
  ];

  List<Map<String, dynamic>> commuteData = [];

  String? selectedBaranggay;
  String? selectedDestination;

  Future<void> getCommuteGuide(String baranggay, String destination) async {
    List<Map<String, dynamic>> receivedCommuteData = await FirestoreServices()
        .getCommuteGuideCollection(baranggay, destination);

    setState(() {
      commuteData = receivedCommuteData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    baranggayList.sort((a, b) => a.compareTo(b));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 10,
          shadowColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Baranggay DropDown
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  value: selectedBaranggay,
                  items: baranggayList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedBaranggay = val as String;
                    });
                  },
                  icon: Icon(
                    Icons.expand_circle_down_outlined,
                    size: screenHeight * 0.03158,
                    color: Colors.black,
                  ),

                  style: TextStyle(
                      color: Colors.black, // White text for the selected item
                      fontSize: screenHeight * 0.01945,
                      fontFamily: "Arvo"),
                  dropdownColor:
                      Colors.white, // Background color for the dropdown options
                  menuMaxHeight: screenHeight * 0.4,

                  decoration: InputDecoration(
                    labelText: "Select Baranggay",
                    prefixIcon: Icon(
                      Icons.my_location,
                      size: screenHeight * 0.03158,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(
                        fontSize: screenHeight * 0.01579, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2.0), // White border for enabled state
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2.0), // White border for focused state
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2.0), // Default border color
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              // Destination DropDown
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  value: selectedDestination,
                  items: destinationList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedDestination = val as String;
                    });
                  },
                  icon: Icon(
                    Icons.expand_circle_down_outlined,
                    size: screenHeight * 0.03158,
                    color: Colors.black,
                  ),

                  style: TextStyle(
                      color: Colors.black, // White text for the selected item
                      fontSize: screenHeight * 0.01945,
                      fontFamily: "Arvo"),
                  dropdownColor:
                      Colors.white, // Background color for the dropdown options
                  menuMaxHeight: screenHeight * 0.4,

                  decoration: InputDecoration(
                    labelText: "Select Destination",
                    prefixIcon: Icon(
                      Icons.pin_drop,
                      size: screenHeight * 0.03158,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(
                        fontSize: screenHeight * 0.01579, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2.0), // White border for enabled state
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2.0), // White border for focused state
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2.0), // Default border color
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                        fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      await getCommuteGuide(
                          selectedBaranggay!, selectedDestination!);
                      setState(() {});
                    },
                    child: Text("Search")),
              )
            ],
          ),
        ),
        Expanded(
          child: commuteData.isEmpty
              ? Center(
                  child: Text("No Baranggay and Destination selected",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
              : ListView.builder(
                  itemCount: commuteData.length,
                  itemBuilder: (context, index) {
                    // Assuming each item in commuteData is a Map
                    var item = commuteData[index];

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                      child: Card(
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.red.shade900,
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Commute Guide",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.red.shade900,
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                  "$selectedBaranggay to $selectedDestination",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: Divider(
                                thickness: 2,
                                color: Colors.black,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap:
                                  true, // This makes the list take up only as much space as its content
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: item['guide'].length,
                              itemBuilder: (context, index) {
                                List<dynamic> steps =
                                    item['guide'][getOption(index)]['steps'];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Colors.blue.shade900,
                                      margin: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.01),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${getOption(index)} ${item['guide'][getOption(index)]['via'] != 'none' ? '(${item['guide'][getOption(index)]['via']})' : ''}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap:
                                          true, // This makes the list take up only as much space as its content
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: steps.length,
                                      itemBuilder: (context, index) {
                                        String step = steps[index];

                                        // Split the text into the part before and after the colon
                                        int colonIndex = step.indexOf(':');
                                        String boldPart = step.substring(
                                            0,
                                            colonIndex +
                                                1); // Include the colon
                                        String remainingText =
                                            step.substring(colonIndex + 1);

                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${index + 1}. $boldPart",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: remainingText,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "* For more assistance: ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Feel free to ask locals, like security guards or transport operators, but make sure to approach the right people. You can also rely on the app’s navigation support to guide you.",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "* For a smoother commute: ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Try using a ride-hailing app to make your travel more convenient and hassle-free.",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider()
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

  String getOption(int index) {
    switch (index) {
      case 0:
        return "Option A";
      case 1:
        return "Option B";
      default:
        return "None";
    }
  }
}
