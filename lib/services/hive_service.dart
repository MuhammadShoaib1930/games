import 'package:flutter/foundation.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/models/magic_square.dart';
import 'package:games/models/sudoku_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static final _instance = HiveService._internal();
  HiveService._internal();
  factory HiveService() => _instance;

  final String settingBoxName = "settingBox";
  final String sudokuBoxName = "sudokuModel";
  final String magicSquareBoxName = "magicSquare";

  Box<AppSettings>? settingBox;
  Box<SudokuModel>? sudokuBox;
  Box<MagicSquare>? magicSquareBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(SudokuModelAdapter());
    Hive.registerAdapter(MagicSquareAdapter());
    await openBoxes();
  }

  Future<void> openBoxes() async {
    settingBox = await Hive.openBox<AppSettings>(settingBoxName);
    sudokuBox = await Hive.openBox<SudokuModel>(sudokuBoxName);
    magicSquareBox = await Hive.openBox<MagicSquare>(magicSquareBoxName);
  }

  dynamic getDataFormBox({required Box box}) {
    if (box is AppSettings) {
      return box.get(settingBoxName) ??
          AppSettings(isDark: false, profileImagePath: "", userName: "Guest");
    } else if (box is SudokuModel) {
      return box.get(sudokuBoxName) ?? SudokuModel(score: 0, tries: 3, level: 1, difficulty: 10);
    } else {
      return box.get(magicSquareBoxName) ?? MagicSquare(level: 1, score: 0);
    }
  }

  dynamic updateBoxData({
    required Box box,
    bool? isDark,
    String? profileImagePath,
    String? userName,
    int? score,
    int? tries,
    int? level,
    int? difficulty,
  }) {
    if (box is AppSettings) {
      box.put(
        settingBoxName,
        getAppSettings().copyWith(
          isDark: isDark,
          profileImagePath: profileImagePath,
          userName: userName,
        ),
      );
    } else if (box is SudokuModel) {
      box.put(
        sudokuBoxName,
        getSudoku().copyWith(score: score, tries: tries, level: level, difficulty: difficulty),
      );
    } else {
      box.put(magicSquareBoxName, getDataFormBox(box: box).copyWith(score: score, level: level));
    }
  }

  AppSettings getAppSettings({Box<AppSettings>? box}) {
    if (box != null) {
      settingBox = box;
    }
    return settingBox!.get(settingBoxName) ??
        AppSettings(isDark: false, profileImagePath: "", userName: "Guest");
  }

  SudokuModel getSudoku() {
    return sudokuBox!.get(sudokuBoxName) ??
        SudokuModel(score: 0, tries: 3, level: 1, difficulty: 10);
  }

  void updateAppSettings({bool? isDark, String? profileImagePath, String? userName}) {
    settingBox!.put(
      settingBoxName,
      getAppSettings().copyWith(
        isDark: isDark,
        profileImagePath: profileImagePath,
        userName: userName,
      ),
    );
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

  ValueListenable<Box<dynamic>> getListenableAppSettingsFormBox({required Box box}) {
    String key = "";
    if (box is AppSettings) {
      key = sudokuBoxName;
    } else if (box is SudokuModel) {
      key = sudokuBoxName;
    } else {
      key = magicSquareBoxName;
    }
    return box.listenable(keys: [key]);
  }

  ValueListenable<Box<SudokuModel>> getListenableSudoku() {
    return sudokuBox!.listenable(keys: [sudokuBoxName]);
  }
}
