import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String initialValue;
  final String placeholderText;
  final int minLines;
  final int maxLines;
  final bool condition;
  final bool prefix;
  final bool date;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final TextInputType? textinput;

  const InputField(
      {Key? key,
      this.initialValue = "",
      this.placeholderText = "",
      this.minLines = 1,
      this.maxLines = 1,
      this.condition = false,
      this.controller,
      this.onTap,
      this.textinput,
      this.prefix = false,
      this.date = false})
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
        readOnly: condition
            ? true
            : date
                ? true
                : false,
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        keyboardType: textinput,
        obscureText: condition ? true : false,
        decoration: InputDecoration(
            prefixText: prefix ? "+91" : null,
            prefixStyle: TextStyle(color: Colors.white),
            suffixIcon: condition
                ? Icon(Icons.arrow_forward_ios_outlined)
                : date
                    ? Icon(Icons.date_range)
                    : null,
            border: InputBorder.none,
            hintText: placeholderText,
            hintStyle: const TextStyle(fontSize: 15, color: Color(0xFF8F8F9E))),
        onTap: date ? onTap : null,
      ),
    );
  }
}
