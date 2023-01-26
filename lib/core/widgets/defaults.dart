import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

class Defaults {
  static Widget defaultTextFormField({
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? labelText,
    double radius = AppRadius.r10,
    TextStyle? labelStyle,
    Widget? suffixIcon,
    Widget? prefixIcon,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmit,
    bool obscureText = false,
    int maxLine = 1,
    TextDirection textDirection = TextDirection.ltr,
    required BuildContext context,
  }) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      maxLines: maxLine,
      textDirection: textDirection,
      style: Theme.of(context).textTheme.titleMedium,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.all(AppPadding.p20),
        labelText: labelText,
        labelStyle: labelStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onSubmit,
    );
  }

  static Widget defaultTextButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget defaultButton({
    required VoidCallback onPressed,
    String? text,
    bool isUpperCase = false,
    double height = 50,
    double width = double.infinity,
    double radius = 10,
    required BuildContext context,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: Theme.of(context).secondaryHeaderColor, width: 2),
        ),
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toString().toUpperCase() : '$text',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
