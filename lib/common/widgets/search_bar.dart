import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.hintText,
    this.onChange,
    this.onSubmitted,
  }) : super(key: key);

  final String? hintText;
  // final String? initText;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.grey.shade300),
      height: 36.h,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: Icon(Icons.search, size: 24.sp),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.solid,
                  color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.solid,
                  color: Colors.transparent)),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
        onChanged: (value) {
          onChange?.call(value);
        },
      ),
    );
  }
}
