import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:taguig_tourism_mobile_app/services/messages_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ChatSupportPage extends StatefulWidget {
  const ChatSupportPage({super.key});

  @override
  State<ChatSupportPage> createState() => _ChatSupportPageState();
}

class _ChatSupportPageState extends State<ChatSupportPage> {
  List<Message> messages = [];

  Interpreter? _interpreter;
  List<String> classes = [];

  @override
  void initState() {
    super.initState();
    initialize();
    introMessage();
  }

  void introMessage() {
    setState(() {
      messages.insert(
          0,
          Message(
              isSentByMe: false,
              text: 'Welcome to our chat support! How can I help you today?',
              date: DateTime.now()));
    });
  }

  Future<void> initialize() async {
    classes = await loadClasses();
    _interpreter = await loadModel();
  }

  // Function to load the model
  Future<Interpreter> loadModel() async {
    try {
      return await Interpreter.fromAsset(
          'lib/models/chatbot_model/chatbot_model.tflite');
    } catch (e) {
      print('Error loading model: $e');
      rethrow;
    }
  }

  Future<String> chatWithBot(String userInput) async {
    if (_interpreter == null) {
      return 'Model not loaded yet';
    }

    if (userInput.trim().isEmpty) {
      return "It seems like you didn't type anything. Can I help with something specific?";
    }

    // Preprocess the input and get the input data
    List<int> inputData = await preprocessInput(userInput);

    // Ensure inputData has the correct shape for the model ([1, words.length])
    var inputDataReshaped = inputData.reshape([1, inputData.length]);
    var outputData =
        List.filled(classes.length, 0.0).reshape([1, classes.length]);

    try {
      _interpreter!.run(inputDataReshaped, outputData);

      // Get the predicted class index and confidence
      int responseIndex = getPredictedClassIndex(outputData[0]);
      double confidence = outputData[0][responseIndex];

      print("Confidence: $confidence");

      String predictedTag = classes[responseIndex];

      if (confidence < 0.7) {
        return getFallbackResponse();
      }

      return await getResponsesForTag(predictedTag);
    } catch (e) {
      print('Error during inference: $e');
      return 'Error during chat';
    }
  }

  String getFallbackResponse() {
    // List of fallback responses
    List<String> fallbackResponses = [
      "I'm sorry, I don't have the information you're looking for.",
      "Unfortunately, I don't have data related to that question.",
      "It seems your question is outside the scope of my knowledge base.",
      "I apologize, but I don't have the details needed to answer that question.",
      "That question is a bit beyond my current capabilities. Can I assist you with something else?",
      "I'm not equipped with the data to answer that. Could you try rephrasing your question?",
      "I don't have sufficient information about that topic, but I'm here to help with other queries.",
      "Sorry, but I can't find any relevant data in my system to answer your question.",
      "That topic doesn't seem to be covered in my dataset. Let me know if there's another way I can help.",
      "I'm unable to provide an answer as it falls outside my dataset's coverage."
    ];

    // Return a random fallback response
    return fallbackResponses[Random().nextInt(fallbackResponses.length)];
  }

  Future<List<int>> preprocessInput(String userInput) async {
    List<String> words = await loadWords();

    // Lemmatize user input (use a Dart lemmatization package if available)
    List<String> userWords = userInput
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .map((word) => lemmatize(word)) // Add lemmatization here
        .toList();

    List<int> bag = List.filled(words.length, 0);
    for (String word in userWords) {
      int index = words.indexOf(word);
      if (index != -1) {
        bag[index] = 1;
      }
    }

    return bag;
  }

  String lemmatize(String word) {
    // Example of basic rules-based lemmatization
    if (word.endsWith('s') && !word.endsWith('ss')) {
      return word.substring(0, word.length - 1); // Remove plural 's'
    }
    return word;
  }

  Future<List<String>> loadClasses() async {
    String jsonString =
        await rootBundle.loadString('lib/models/chatbot_model/classes.json');
    List<String> classes = List<String>.from(json.decode(jsonString));
    return classes;
  }

  Future<List<String>> loadWords() async {
    String jsonString =
        await rootBundle.loadString('lib/models/chatbot_model/words.json');

    List<String> words = List<String>.from(json.decode(jsonString));

    return words;
  }

  int getPredictedClassIndex(List<double> output) {
    return output
        .indexWhere((prob) => prob == output.reduce((a, b) => a > b ? a : b));
  }

  Future<Map<String, dynamic>> loadIntents() async {
    String jsonString =
        await rootBundle.loadString('lib/models/chatbot_model/intents.json');
    Map<String, dynamic> intents = json.decode(jsonString);
    return intents;
  }

  Future<String> getResponsesForTag(String tag) async {
    Map<String, dynamic> intents = await loadIntents();

    for (var intent in intents['intents']) {
      if (intent['tag'] == tag) {
        List<String> responses = List<String>.from(intent['responses']);
        if (responses.isNotEmpty) {
          // Return a random response
          return responses[Random().nextInt(responses.length)];
        } else {
          return "I'm not sure how to respond to that.";
        }
      }
    }
    return "I'm not sure how to respond to that.";
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController userQuestion = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.shade700,
                Colors.redAccent.shade700
              ], // Specify your gradient colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Chat Support',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<Message, DateTime>(
            padding: EdgeInsets.all(screenHeight * 0.0125),
            reverse: true,
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (messages) => DateTime(
                messages.date.year, messages.date.month, messages.date.day),
            groupHeaderBuilder: (Message message) => SizedBox(
              height: screenHeight * 0.0625,
              child: Center(
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight * 0.0125),
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Message message) => Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
              child: Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: message.isSentByMe
                      ? Colors.blue.shade100
                      : Colors.grey.shade200,
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    child: Text(message.text),
                  ),
                ),
              ),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: screenHeight * 0.060,
                  child: TextField(
                    cursorHeight: 20,
                    cursorColor: Colors.grey,
                    controller: userQuestion,
                    decoration: InputDecoration(
                      labelText: "Type your question here...",
                      prefixIcon:
                          Icon(Icons.chat, color: Colors.blueAccent.shade700),
                      suffix: IconButton(
                          onPressed: () async {
                            setState(() {
                              messages.insert(
                                  0,
                                  Message(
                                      text: userQuestion.text,
                                      date: DateTime.now(),
                                      isSentByMe: true));
                            });

                            messages.insert(
                                0,
                                Message(
                                    text: "...",
                                    date: DateTime.now(),
                                    isSentByMe: false));

                            String chatResponse =
                                await chatWithBot(userQuestion.text);
                            await Future.delayed(Duration(seconds: 2));

                            setState(() {
                              messages.removeWhere(
                                  (message) => message.text == "...");
                              messages.insert(
                                  0,
                                  Message(
                                      text: chatResponse,
                                      date: DateTime.now(),
                                      isSentByMe: false));
                              userQuestion.clear();
                            });
                          },
                          icon: Icon(Icons.send,
                              color: Colors.blueAccent.shade700)),
                      labelStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: screenHeight * 0.01842,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade900,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade900,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenHeight * 0.01842,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
