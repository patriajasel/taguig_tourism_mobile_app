import 'package:flutter/material.dart';

class GenerateWidget {
  TextField generateTextField(
      BuildContext context, String hintText, IconData icon, TextEditingController controller,
      {bool? obscureText}) 
      {
      double screenHeight = MediaQuery.of(context).size.height;
    return TextField(
      cursorHeight: screenHeight * 0.01842,
      cursorColor: Colors.white,
      obscureText: obscureText ?? false,
      controller: controller,
      expands: false,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(icon, color: Colors.yellowAccent),

        // Label style size
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: screenHeight * 0.01842,
          fontWeight: FontWeight.bold,
        ),

        // Border Styles
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white, // White border for the enabled state
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color:
                Colors.yellowAccent, // White border when the field is focused
            width: 2.0, // Optional: you can increase the border width
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red, // Red border for the error state
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red, // Red border when focused with error
            width: 2.0,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.01842), // Text color set to white
    );
  }

  // * This is for generating elevated button
  ElevatedButton generateElevatedButton(
      BuildContext context, String text, Color color, Color textColor, Function() function,
      {Icon? icon}) {
        double screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Black background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01974), // Adjust padding for height
      ),
      onPressed: () {
        function();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon,
          Padding(
            padding: EdgeInsets.only(left: screenHeight * 0.00658),
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: screenHeight * 0.01842), // White text
            ),
          ),
        ],
      ),
    );
  }

  InkWell generateTextLink(
    BuildContext context, String text, String routeName, Color color) {
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.01842,
              color: Colors.yellowAccent,
              decoration: TextDecoration.underline,
              decorationColor: color,
              ),
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        });
  }

  Text generateTitleField(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
      textAlign: TextAlign.left,
    );
  }

  Flexible generatedProfileTextField(String placeholders) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.shade700,
                Colors.redAccent.shade700,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(
              placeholders,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
