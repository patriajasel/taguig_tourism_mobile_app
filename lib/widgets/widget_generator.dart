import 'package:flutter/material.dart';

class GenerateWidget {
  Widget generateTextField(
    BuildContext context,
    String hintText,
    IconData icon,
    TextEditingController controller, {
    bool isPassword = false,
    ValueNotifier<bool>? obscureTextNotifier,
  }) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier ?? ValueNotifier(false),
      builder: (context, obscureText, child) {
        return TextField(
          cursorHeight: screenHeight * 0.01842,
          cursorColor: Colors.white,
          obscureText: isPassword ? obscureText : false,
          controller: controller,
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: Icon(icon, color: Colors.yellowAccent),
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () {
                      if (obscureTextNotifier != null) {
                        obscureTextNotifier.value = !obscureTextNotifier.value;
                      }
                    },
                    child: Icon(
                      obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.yellowAccent,
                    ),
                  )
                : null,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.01842,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.yellowAccent,
                width: 2.0,
              ),
            ),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.01842,
          ),
        );
      },
    );
  }

  ElevatedButton generateElevatedButton(
    BuildContext context,
    String text,
    Color color,
    Color textColor,
    Function() function, {
    Icon? icon,
  }) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01974),
      ),
      onPressed: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon,
          Padding(
            padding: EdgeInsets.only(left: screenHeight * 0.00658),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: screenHeight * 0.01842,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell generateTextLink(
    BuildContext context,
    String text,
    String routeName,
    Color color,
  ) {
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
      },
    );
  }

  Text generateTitleField(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.left,
    );
  }

  Flexible generateProfileTextField(String placeholder) {
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                placeholder,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
