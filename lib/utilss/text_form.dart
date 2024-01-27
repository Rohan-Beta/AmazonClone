import 'package:flutter/material.dart';

class SignInTextForm extends StatefulWidget {
  final TextEditingController myController;
  final Icon myIcon;
  final String myHintText;
  final String myText;
  const SignInTextForm({
    super.key,
    required this.myController,
    required this.myHintText,
    required this.myText,
    required this.myIcon,
  });

  @override
  State<SignInTextForm> createState() => _SignInTextFormState();
}

class _SignInTextFormState extends State<SignInTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return widget.myText;
        }
        return null;
      },
      controller: widget.myController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: widget.myIcon,
        hintText: widget.myHintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
