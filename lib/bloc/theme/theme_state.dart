part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final String userName;
  final bool isDark;
  const ThemeState({this.userName = "Guest", this.isDark = false});

  @override
  List<Object> get props => [userName, isDark];

  ThemeState copyWith({String? userName, bool? isDark}) {
    return ThemeState(userName: userName ?? this.userName, isDark: isDark ?? this.isDark);
  }
}
