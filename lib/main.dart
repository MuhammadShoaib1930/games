import 'package:flutter/material.dart';
import 'package:games/my_app.dart';
import 'package:games/services/hive_service.dart';

void main() async {
  await HiveService().init();
  runApp(const MyApp());
}
