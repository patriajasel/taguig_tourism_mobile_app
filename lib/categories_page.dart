import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  final String headline;
  const CategoriesPage({super.key, required this.headline});

  @override
  State<CategoriesPage> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headline),
      ),
      body: SingleChildScrollView(child: ListView()),
    );
  }
}
