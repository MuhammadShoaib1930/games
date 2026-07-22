import 'package:flutter/foundation.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/models/magic_square.dart';
import 'package:games/models/stroop_model.dart';
import 'package:games/models/sudoku_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static final _instance = HiveService._internal();
  HiveService._internal();
  factory HiveService() => _instance;

  final String settingBoxName = "settingBox";
  final String sudokuBoxName = "sudokuModel";
  final String magicSquareBoxName = "magicSquare";
  final String stroopBoxName = "stroopModel";

  late Box<AppSettings> settingBox;
  late Box<SudokuModel> sudokuBox;
  late Box<MagicSquare> magicSquareBox;
  late Box<StroopModel> stroopBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(SudokuModelAdapter());
    Hive.registerAdapter(MagicSquareAdapter());
    Hive.registerAdapter(StroopModelAdapter());
    await openBoxes();
  }

  Future<void> openBoxes() async {
    settingBox = await Hive.openBox<AppSettings>(settingBoxName);
    sudokuBox = await Hive.openBox<SudokuModel>(sudokuBoxName);
    magicSquareBox = await Hive.openBox<MagicSquare>(magicSquareBoxName);
    stroopBox = await Hive.openBox<StroopModel>(stroopBoxName);
  }

  T getDataFormBox<T>({required Box<T> box}) {
    if (T == AppSettings) {
      return box.get(settingBoxName) ??
          AppSettings(isDark: false, profileImagePath: "", userName: "Guest") as T;
    } else if (T == SudokuModel) {
      return box.get(sudokuBoxName) ??
          SudokuModel(score: 0, tries: 3, level: 1, difficulty: 10) as T;
    } else if (T == MagicSquare) {
      return box.get(magicSquareBoxName) ?? MagicSquare(level: 1, score: 0) as T;
    } else {
      return box.get(stroopBoxName) ??
          StroopModel(stropTextMaxScore: 0, stropEffectMaxScore: 0) as T;
    }
  }

  void updateBoxData<T>({
    required Box<T> box,
    bool? isDark,
    String? profileImagePath,
    String? userName,
    int? score,
    int? tries,
    int? level,
    int? difficulty,
    int? scoreText,
    int? scoreEffect,
  }) {
    if (T == AppSettings) {
      final data = getDataFormBox<T>(box: box) as AppSettings;
      box.put(
        settingBoxName,
        data.copyWith(isDark: isDark, profileImagePath: profileImagePath, userName: userName) as T,
      );
    } else if (T == SudokuModel) {
      final data = getDataFormBox<T>(box: box) as SudokuModel;
      box.put(
        sudokuBoxName,
        data.copyWith(score: score, tries: tries, level: level, difficulty: difficulty) as T,
      );
    } else if (T == MagicSquare) {
      final data = getDataFormBox<T>(box: box) as MagicSquare;
      box.put(magicSquareBoxName, data.copyWith(score: score, level: level) as T);
    } else {
      final data = getDataFormBox<T>(box: box) as StroopModel;
      box.put(
        stroopBoxName,
        data.copyWith(
              stropTextMaxScore: scoreText,
              stropEffectMaxScore: scoreEffect
            )
            as T,
      );
    }
  }

  ValueListenable<Box<T>> getListenableAppSettingsFormBox<T>({required Box<T> box}) {
    if (T == AppSettings) {
      return box.listenable();
    } else if (T == SudokuModel) {
      return box.listenable();
    } else {
      return box.listenable();
    }
  }

  bool isDark() {
    return getDataFormBox<AppSettings>(box: settingBox).isDark;
  }
}
