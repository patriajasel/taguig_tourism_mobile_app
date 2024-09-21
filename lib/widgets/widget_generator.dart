import 'package:flutter/material.dart';

class GenerateWidget {
  TextField generateTextField(
      String hintText, IconData icon, TextEditingController controller,
      {bool? obscureText}) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      expands: false,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(icon, color: Colors.yellowAccent),

        // Label style size
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
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
      style: const TextStyle(color: Colors.white), // Text color set to white
    );
  }

  ElevatedButton generateElevatedButton(
      String text, Color color, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Black background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15), // Adjust padding for height
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 14.0), // White text
          ),
        ],
      ),
    );
  }

  InkWell generateTextLink(
      BuildContext context, String text, String routeName, Color color) {
    return InkWell(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
              decoration: TextDecoration.underline,
              decorationColor: color),
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        });
  }
}
