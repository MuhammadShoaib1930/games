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
  }

  AppSettings getAppSettings() {
    return settingBox!.get(settingBoxName) ?? AppSettings(isDark: false, profileImagePath: "");
  }

  SudokuModel getSudoku() {
    return sudokuBox!.get(sudokuBoxName) ??
        SudokuModel(score: 0, tries: 3, level: 1, difficulty: 10);
  }

  void updateAppSettings({bool? isDark,String? profileImagePath}) {
    settingBox!.put(settingBoxName, getAppSettings().copyWith(isDark: isDark,profileImagePath: profileImagePath));
  }

  void updateSudoku({int? score, int? tries, int? level, int? difficulty}) {
    sudokuBox!.put(
      sudokuBoxName,
      getSudoku().copyWith(score: score, tries: tries, level: level, difficulty: difficulty),
    );
  }

  ValueListenable<Box<AppSettings>> getListenableAppSettings() {
    return settingBox!.listenable(keys: [settingBoxName]);
  }

  ValueListenable<Box<SudokuModel>> getListenableSudoku() {
    return sudokuBox!.listenable(keys: [sudokuBoxName]);
  }
}
