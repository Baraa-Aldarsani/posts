import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final bool multiLine;
  final TextEditingController controller;
  const TextFormFieldWidget(
      {super.key,
      required this.name,
      required this.multiLine,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can’t be empty" : null,
        decoration: InputDecoration(hintText: name),
        minLines: multiLine ? 6 : 1,
        maxLines: multiLine ? 6 : 1,
      ),
    );
  }
}
