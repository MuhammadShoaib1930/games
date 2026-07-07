import 'package:flutter/material.dart';
import 'package:games/my_app.dart';
import 'package:games/services/hive_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await WakelockPlus.enable();
  runApp(const MyApp());
}
