import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/services/hive_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final HiveService hiveService = HiveService();
  ThemeCubit() : super(ThemeState());
  void themeTogel() {
    emit(state.copyWith(isDark: HiveService().getAppSettings().isDark));
  }
}
