import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String initialValue;
  final String placeholderText;
  final int minLines;
  final int maxLines;
  final bool condition;

  const InputField(
      {Key? key,
      this.initialValue = "",
      this.placeholderText = "",
      this.minLines = 1,
      this.maxLines = 1,
      this.condition = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          // color: const Color(0xFF1E1C24),
          border: Border.all(color: const Color(0xFF5D5D67)),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        initialValue: initialValue,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
            suffixIcon:
                condition ? Icon(Icons.arrow_forward_ios_outlined) : null,
            border: InputBorder.none,
            hintText: placeholderText,
            hintStyle: const TextStyle(fontSize: 15, color: Color(0xFF8F8F9E))),
      ),
    );
  }
}
