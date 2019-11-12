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
}
