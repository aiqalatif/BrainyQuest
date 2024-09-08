import 'package:brain_master/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormComponent extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  FormComponent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<FormComponent> createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: widget.emailController,
            labelText: 'Email',
            prefixIcon: Image.asset(
              'assets/images/email.png',
              scale: 5,
            ),
            borderColor: Colors.white,
            focusedBorderColor: Colors.red,
            textColor: Colors.white,
            labelColor: Colors.white70,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final RegExp emailRegex = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: widget.passwordController,
            labelText: 'Password',
            prefixIcon: Image.asset(
              'assets/images/password_lock.png',
              scale: 4,
            ),
            suffixIcon: Consumer<TextFormFieldState>(
              builder: (context, state, _) {
                return GestureDetector(
                  onTap: state.toggleObscureText,
                  child: Image.asset(
                    state.obscureText
                        ? 'assets/images/password_eye.png'
                        : 'assets/images/password_eye.png',
                    scale: 5,
                  ),
                );
              },
            ),
            obscureText: true,
            borderColor: Colors.white,
            focusedBorderColor: Colors.red,
            textColor: Colors.white,
            labelColor: Colors.white70,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Password must contain at least one uppercase letter';
              }
              if (!RegExp(r'[a-z]').hasMatch(value)) {
                return 'Password must contain at least one lowercase letter';
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Password must contain at least one digit';
              }
              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Password must contain at least one special character';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
