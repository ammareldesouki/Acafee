  import 'package:flutter/material.dart';

  
  class BuildTextFieldForm extends StatelessWidget {
    final TextEditingController controller;
    final String label;
    final bool obscureText;

    const BuildTextFieldForm({super.key, 
      required this.controller,
      required this.label,
      this.obscureText = false,
    });
  @override
  Widget build(BuildContext context) {
    return _buildTextField(controller, label, obscureText: obscureText);
  }
  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
