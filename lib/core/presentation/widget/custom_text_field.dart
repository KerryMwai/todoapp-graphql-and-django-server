import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.textEditingController});

  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return    Padding(
          padding:const  EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: textEditingController,
            decoration:const  InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter todo title',
            ),
          ),
        );
  }
}