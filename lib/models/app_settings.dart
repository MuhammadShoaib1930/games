import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 0)
class AppSettings {
  @HiveField(0)
  final bool isDark;
  @HiveField(1)
  final String profileImagePath;
  @HiveField(2)
  final String userName;
  AppSettings({required this.isDark, required this.profileImagePath, required this.userName});

  AppSettings copyWith({bool? isDark, String? profileImagePath, String? userName}) {
    return AppSettings(
      isDark: isDark ?? this.isDark,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      userName: userName ?? this.userName,
    );
  }
}
