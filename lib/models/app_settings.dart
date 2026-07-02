import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 0)
class AppSettings {
  @HiveField(0)
  final bool isDark;
  @HiveField(1)
  final String profileImagePath;
  AppSettings({required this.isDark, required this.profileImagePath});

  AppSettings copyWith({bool? isDark, String? profileImagePath}) {
    return AppSettings(
      isDark: isDark ?? this.isDark,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
