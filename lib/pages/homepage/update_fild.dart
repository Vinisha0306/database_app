import 'package:flutter/material.dart';

Widget UpdateFild({required initialValue, required onChanged, required title}) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
    ),
  );
}
