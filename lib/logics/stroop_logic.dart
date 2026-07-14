import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StroopLogic {
  static final List<Color> listColor = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.brown,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.yellow,
  ];
  static final List<String> listName = [
    "black",
    "white",
    'blue',
    'brown',
    'green',
    'grey',
    'orange',
    'pink',
    'purple',
    'red',
    'yellow',
  ];

  (int, List<int>) generateNew() {
    int n = listColor.length;
    int correct = Random().nextInt(n);
    Set<int> result = {correct};
    while (result.length < 4) {
      result.add(Random().nextInt(n));
    }
    return (correct, _mix(result.toList()));
  }

  List<int> _mix(List<int> list) {
    int n = list.length;
    int i = 0, j = 0;
    while (i == j) {
      i = Random().nextInt(n);
      j = Random().nextInt(n);
    }
    list[i] = list[i] ^ list[j];
    list[j] = list[i] ^ list[j];
    list[i] = list[i] ^ list[j];
    return list;
  }

  Color mainTextColor(int index) {
    return listColor[index];
  }

  String mainTextName(List<int> list) {
    return listName[list[Random().nextInt(list.length)]];
  }

}
