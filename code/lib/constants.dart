library constants;

import 'package:flutter/material.dart';

const MaterialColor mainColor = Colors.teal;
const Color textColor = Colors.white;
const MaterialColor accentColor = Colors.amber;

// Colored print() functions using ANSI escape codes for better debugging

void printError(String text) => printColored(31, text); // red

void printSuccess(String text) => printColored(32, text); // green

void printWarning(String text) => printColored(33, text); // yellow

void printInfo(String text) => printColored(34, text); // blue

/*
void printXXX(String text) => printColored(35, text); // magenta
void printYYY(String text) => printColored(36, text); // cyan
void printZZZ(String text) => printColored(37, text); // white
 */

void printColored(int value, String text) {
  print("\x1B[${value.toString()}m$text\x1B[0m");
}