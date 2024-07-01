
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/my_color.dart';
import '../styles/txt_style.dart';

class PlainTextField extends StatelessWidget {

  final String? hintText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final TextEditingController? controller;
  final Function(String text)? onChanged;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final String? prefixString;

  PlainTextField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.isObscure,
    this.onChanged,
    this.controller,
    this.textAlign,
    this.textStyle,
    this.focusNode,
    this.prefixString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure ?? false,
      style: textStyle ?? MyTextStyle.formInput,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      cursorColor: MyColor.kPrimary,
      textAlign: textAlign ?? TextAlign.left,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (text) {
        if(onChanged != null) {
          onChanged!(text);
        }
      },
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColor.bg03,
        focusedBorder: plainOutlineInputBorder(),
        enabledBorder: plainOutlineInputBorder(),
        hintText: hintText ?? '',
        hintStyle: MyTextStyle.formInput.copyWith(
          color: MyColor.typo01,
        ),
        counterText:'',
        prefixText: prefixString ?? ''
      ),
    );
  }

  OutlineInputBorder plainOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: MyColor.gray_02,
        width: 1.2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }
}
