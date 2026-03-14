import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin CustomTextFieldWidgets {
  Widget customTextField(
    String text,
    TextInputType? keyboardType, {
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    void Function()? onTap,
    bool readonly = false,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onTap: onTap,
        readOnly: readonly,
        decoration: InputDecoration(
            hintText: "Enter $text",
            label: Text(text),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.redAccent, width: 1))),
      ),
    );
  }

  TextStyle customTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle customTextStyle3 = TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  TextStyle customTextStyle2 = TextStyle(fontSize: 19, fontWeight: FontWeight.w400);
}
