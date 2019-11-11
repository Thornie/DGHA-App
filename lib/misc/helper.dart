import 'dart:convert';
import 'package:flutter/material.dart';

class Helper {
  Future<String> loadTxtFiles(BuildContext _context, fileName) async {
    var string = await DefaultAssetBundle.of(_context).loadString(fileName);
    return string;
  }

  Future<List<String>> loadMd(BuildContext _context, fileName) async {
    var string = await DefaultAssetBundle.of(_context).loadString(fileName);

    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(string);

    return lines;
  }

  String formatStringForQuery(String input) {
    // remove white space
    String formattedInput = input.trim();

    // join with +
    formattedInput = formattedInput.split(" ").join("+");

    return formattedInput;
  }

  String formatAddress(String input) {
    int indexOfState = input.indexOf("VIC");
    if (indexOfState == -1) {
      indexOfState = input.indexOf("Australia");
    }
    String newInput = input.substring(0, indexOfState);

    return newInput;
  }
}
