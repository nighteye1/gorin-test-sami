import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final String placeHolderText;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? suffix;
  final void Function(String)? onChange;
  const AppTextField({
    super.key,
    this.placeHolderText = '',
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.suffix,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final AppTextStyles styles = AppTextStyles();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48.h,
      child: CupertinoTextField(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],
        ),
        controller: controller,
        focusNode: focusNode,
        placeholder: placeHolderText,
        placeholderStyle: styles.kRegularTextStyle,
        style: styles.kRegularTextStyle,
        obscureText: obscureText,
        onChanged: onChange,
        padding: const EdgeInsets.symmetric(horizontal: 16).w,
        suffix: suffix,
        suffixMode: OverlayVisibilityMode.always,
      ),
    );
  }
}
