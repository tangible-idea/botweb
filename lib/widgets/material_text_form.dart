import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:prayers/styles/txt_style.dart';

class MaterialTextForm extends StatelessWidget {
  MaterialTextForm({super.key,
    this.initialValue,
    required this.labelText,
    required this.helperText,
    this.validationErrorText,
    this.onChanged,
    this.onSaved,
    this.icon,
    this.maxLength,
    this.controller,
    this.onlyUppercase
  });

  String? initialValue;
  String labelText;
  String helperText;
  String? validationErrorText;
  Icon? icon;
  int? maxLength;
  Function(String?)? onSaved;
  Function(String?)? onChanged;
  TextEditingController? controller;
  bool? onlyUppercase;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      maxLength: maxLength ?? 20,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        // default validator
        if (value == null || value.isEmpty) {
          return validationErrorText ?? "Please type something here.";
        }
        // Add more complex validation if needed
        return null; // Return null if the input is valid
      },
      textCapitalization: onlyUppercase == true ? TextCapitalization.characters : TextCapitalization.none,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        labelStyle: FigmaTextStyles.content16,
        helperText: helperText,
        suffixIcon: null,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: MyColor.kSecondary),
        ),
      ),
    );
  }
}
