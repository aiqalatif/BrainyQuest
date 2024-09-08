import 'package:brain_master/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String name;
  final double fontSize; // New property for font size

  CustomButton({
    super.key,
    required this.onPress,
    required this.name,
    this.fontSize = 14.0, // Default value for font size
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFCF4F5B),
              Color(0xFFDC0038),
            ],
            // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(40), // Border radius
        ),
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            // Background color must be transparent
            elevation: 0,
            // Remove the shadow to see the gradient
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), // Border radius
            ),
          ),
          child: CText(
            text: name,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold// Use the provided font size
            ),
          ),
        ),
      ),
    );
  }
}
