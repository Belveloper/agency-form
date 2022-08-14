import 'package:flutter/material.dart';

Widget defaultTextField(
        {TextEditingController? controller,
        labeltext,
        keyboardType,
        function,
        validator}) =>
    TextFormField(
        onTap: function,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: labeltext,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
Future customDialog(
        {required String? title,
        required String label,
        required Icon icon,
        required BuildContext context}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title!),
              content: Row(
                children: [
                  Flexible(flex: 2, child: Text(label)),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(flex: 1, child: icon),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ));
