import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.controller,
    this.prefix,
    required this.hintText,
    required this.onChanage,
    this.isIcon = false,
    this.maxLength = 10,
    this.action = TextInputAction.done,
    this.errorText,
    this.inputType = TextInputType.number,
    this.icon,
    this.iconButton, this.autoFoaus,
  });
  final TextEditingController controller;
  final Widget? prefix;
  final String hintText;
  final bool isIcon;
  final Widget? icon;
  final int maxLength;
  final String? errorText;
  final TextInputAction action;
  final TextInputType inputType;
  final bool? autoFoaus;
  final Function(String value) onChanage;
  final Widget? iconButton;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      autofocus: autoFoaus ?? true,
      textInputAction: action,
      onChanged: onChanage,
      maxLength: maxLength,
      keyboardType: inputType,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15.sp),
      cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        helperText: errorText,
        helperStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 8.sp),
        prefix: isIcon ? null : prefix,
        prefixIcon: isIcon ? icon : null,
        suffixIcon: iconButton ?? null,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
      ),
    );
  }
}
