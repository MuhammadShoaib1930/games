import 'package:flutter/foundation.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/models/sudoku_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static final _instance = HiveService._internal();
  HiveService._internal();
  factory HiveService() => _instance;

  final String settingBoxName = "settingBox";
  final String sudokuBoxName = "sudokuModel";
  Box<AppSettings>? settingBox;
  Box<SudokuModel>? sudokuBox;
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(SudokuModelAdapter());
    await openBoxes();
  }

  Future<void> openBoxes() async {
    settingBox = await Hive.openBox<AppSettings>(settingBoxName);
    sudokuBox = await Hive.openBox<SudokuModel>(sudokuBoxName);
    defaultValue();
  }

  Future<void> defaultValue() async {
    await settingBox!.put(settingBoxName, AppSettings(isDark: false));
    await sudokuBox!.put(sudokuBoxName, SudokuModel(userName: "", score: [], time: [], lost: 0));
  }

  AppSettings getAppSettings() {
    return settingBox!.get(settingBoxName) ?? AppSettings(isDark: false);
  }

  SudokuModel getSudoku() {
    return sudokuBox!.get(sudokuBoxName) ?? SudokuModel(userName: "", score: [], time: [], lost: 0);
  }

  void updateAppSettings({bool? isDark}) {
    settingBox!.put(settingBoxName, getAppSettings().copyWith(isDark: isDark));
  }

  void updateSudoku({int? lost, List<int>? score, List<String>? time, String? userName}) {
    sudokuBox!.put(
      sudokuBoxName,
      getSudoku().copyWith(lost: lost, score: score, time: time, userName: userName),
    );
  }

  ValueListenable<Box<AppSettings>> getListenableAppSettings() {
    return settingBox!.listenable(keys: [settingBoxName]);
  }

  ValueListenable<Box<SudokuModel>> getListenableSudoku() {
    return sudokuBox!.listenable(keys: [sudokuBoxName]);
  }
}
