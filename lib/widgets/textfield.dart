import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hint, title;
  final bool enable;
  final TextEditingController textEditingController;

  const TextInputField(
      {Key? key,
      required this.hint,
      required this.textEditingController,
      required this.title, required this.enable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          keyboardType: TextInputType.text,
          controller: textEditingController,
          enabled: enable,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
      ],
    ));
  }
}
