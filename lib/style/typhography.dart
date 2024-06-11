import 'package:flutter/material.dart';

TextStyle h1({
  Color color = Colors.black,
  bool bold = true,
}) {
  return TextStyle(
    color: color,
    fontSize: 22,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
  );
}

TextStyle h2({
  Color color = Colors.black,
  bool bold = true,
}) {
  return TextStyle(
    color: color,
    fontSize: 20,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
  );
}

TextStyle h3({
  Color color = Colors.black,
  bool bold = true,
}) {
  return TextStyle(
    color: color,
    fontSize: 18,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
  );
}

TextStyle h4({
  Color color = Colors.black,
  bool semibold = true,
}) {
  return TextStyle(
    color: color,
    fontSize: 16,
    fontWeight: semibold ? FontWeight.w600 : FontWeight.normal,
  );
}

TextStyle h5({
  Color color = Colors.black,
  bool semibold = true,
}) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: semibold ? FontWeight.w600 : FontWeight.normal,
  );
}

TextStyle body1({
  Color color = Colors.black,
  bool bold = false,
  bool semibold = false,
  TextDecoration? decoration,
}) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: bold
        ? FontWeight.bold
        : semibold
            ? FontWeight.w600
            : FontWeight.normal,
    decoration: decoration,
  );
}

TextStyle body2({
  Color color = Colors.black,
  bool bold = false,
  bool semibold = false,
}) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: bold
        ? FontWeight.bold
        : semibold
            ? FontWeight.w600
            : FontWeight.normal,
  );
}

TextStyle body3({
  Color color = Colors.black,
  bool bold = false,
  bool semibold = false,
}) {
  return TextStyle(
    color: color,
    fontSize: 12,
    fontWeight: bold
        ? FontWeight.bold
        : semibold
            ? FontWeight.w600
            : FontWeight.normal,
  );
}

TextStyle body4({
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w400,
  bool bold = false,
  bool semibold = false,
}) {
  return TextStyle(
    color: color,
    fontSize: 11,
    fontWeight: bold
        ? FontWeight.bold
        : semibold
            ? FontWeight.w600
            : FontWeight.normal,
  );
}

TextStyle body5({
  Color color = Colors.black,
  bool bold = false,
}) {
  return TextStyle(
    color: color,
    fontSize: 10,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
  );
}

TextStyle paragraf({
  Color color = Colors.black,
  bool bold = false,
}) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    height: 1.6,
  );
}

TextStyle custom({
  Color color = Colors.black,
  FontWeight bold = FontWeight.bold,
  double fontSize = 22,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: bold,
  );
}