import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    this.tec,
    required this.validator,
    required this.hint,
    this.obscure = false,
  }) : super(key: key);

  final TextEditingController? tec;
  final String? Function(String?) validator;
  final bool obscure;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tec,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      obscureText: obscure,
    );
  }
}
