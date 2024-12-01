import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:taguig_tourism_mobile_app/services/messages_model.dart';

class ChatSupportPage extends StatefulWidget {
  const ChatSupportPage({super.key});

  @override
  State<ChatSupportPage> createState() => _ChatSupportPageState();
}

class _ChatSupportPageState extends State<ChatSupportPage> {
  List<Message> messages = [
    Message(
        text: 'Hello',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Hello',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Hello',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Hello',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Hello',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Support'),
      ),
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<Message, DateTime>(
            padding: EdgeInsets.all(screenHeight * 0.0125),
            reverse: true,
            order: GroupedListOrder.DESC,
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
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: screenHeight * 0.01,
                child: Padding(
                  padding: EdgeInsets.all(screenHeight * 0.015),
                  child: Text(message.text),
                ),
              ),
            ),
          )),
          Container(
            color: Colors.grey.shade300,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(screenHeight * 0.015),
                hintText: 'Type your question here...',
              ),
              onSubmitted: (text) {
                final message =
                    Message(text: text, date: DateTime.now(), isSentByMe: true);

                setState(() {
                  messages.add(message);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
