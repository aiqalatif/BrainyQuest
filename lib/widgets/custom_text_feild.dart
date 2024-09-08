
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFieldState extends ChangeNotifier {
  bool _obscureText;
  Color _borderColor;
  final Color focusedBorderColor;

  TextFormFieldState({
    required bool obscureText,
    required Color borderColor,
    required this.focusedBorderColor,
  })  : _obscureText = obscureText,
        _borderColor = borderColor;

  bool get obscureText => _obscureText;

  Color get borderColor => _borderColor;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void updateBorderColor(bool isFocused) {
    _borderColor = isFocused ? focusedBorderColor : _borderColor;
    notifyListeners();
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color textColor;
  final Color labelColor;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.borderColor = Colors.white,
    this.focusedBorderColor = Colors.red,
    this.textColor = Colors.white,
    this.labelColor = Colors.grey,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TextFormFieldState(
        obscureText: obscureText,
        borderColor: borderColor,
        focusedBorderColor: focusedBorderColor,
      ),
      child: Consumer<TextFormFieldState>(
        builder: (context, state, child) {
          return TextFormField(
            controller: controller,
            obscureText: state.obscureText,
            style: TextStyle(color: textColor, fontSize: 14),
            validator: validator,
            onChanged: (text) {
              state.updateBorderColor(text.isNotEmpty);
            },
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: onSuffixIconPressed ?? state.toggleObscureText,
                child: suffixIcon,
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: state.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: state.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: state.borderColor),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: controller.text.isEmpty ? labelText : null,
              labelStyle: TextStyle(color: labelColor),
              errorStyle: const TextStyle(color: Colors.redAccent),
            ),
          );
        },
      ),
    );
  }
}