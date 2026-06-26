import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 0)
class AppSettings {
  @HiveField(0)
  final bool isDark;
  AppSettings({required this.isDark});

  AppSettings copyWith({bool? isDark}) {
    return AppSettings(isDark: isDark ?? this.isDark);
  }
}
