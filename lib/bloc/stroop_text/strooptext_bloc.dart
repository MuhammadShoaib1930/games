import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/logics/stroop_logic.dart';
import 'package:games/models/stroop_model.dart';
import 'package:games/services/hive_service.dart';

part 'strooptext_event.dart';
part 'strooptext_state.dart';

class StrooptextBloc extends Bloc<StrooptextEvent, StrooptextState> {
  int time = 60;
  Timer? _timer;
  StroopLogic stroopLogic = StroopLogic();
  StrooptextBloc() : super(StrooptextState()) {
    on<Solved>(_solved);
    on<InitalStropText>(_inital);
    on<StartTimer>(_startTimer);
    on<ResetTimer>(_resetTimer);
    on<Tick>(_tick);
  }
  HiveService hiveService = HiveService();

  FutureOr<void> _solved(Solved event, Emitter<StrooptextState> emit) {
    if (event.userSelected == state.correctValueIndex) {
      if (event.isText && state.targetScoreText < state.scoreText) {
        hiveService.updateBoxData(
          box: hiveService.stroopBox,
          score: state.scoreText + 10,
          isStroopText: true,
        );
      } else if (!event.isText && state.targetScoreEffect < state.scoreEffect) {
        hiveService.updateBoxData(
          box: hiveService.stroopBox,
          score: state.scoreEffect + 10,
          isStroopText: false,
        );
      }
      int index = 0;
      List<int> list = [];
      (index, list) = stroopLogic.generateNew();
      time = (time < 6) ? 5 : time - 5;
      add(ResetTimer());
      emit(
        state.copyWith(
          correctValueIndex: index,
          optionsList: list,
          scoreText: state.scoreText + 10,
          scoreEffect: state.scoreEffect + 10,
          text: StroopLogic().mainTextName(state.optionsList),
        ),
      );
    } else {
      time = 60;
      add(ResetTimer());
      add(InitalStropText());
    }
  }

  FutureOr<void> _inital(InitalStropText event, Emitter<StrooptextState> emit) {
    int selctedValue = 0;
    List<int> list = [];
    (selctedValue, list) = stroopLogic.generateNew();
    StroopModel stroopModel = hiveService.getDataFormBox<StroopModel>(box: hiveService.stroopBox);

    emit(
      StrooptextState(
        correctValueIndex: selctedValue,
        optionsList: list,
        scoreText: 0,
        targetScoreText: stroopModel.stropTextMaxScore,
        scoreEffect: 0,
        targetScoreEffect: stroopModel.stropEffectMaxScore,

        text: StroopLogic().mainTextName(state.optionsList),
      ),
    );
  }

  void _startTimer(StartTimer event, Emitter<StrooptextState> emit) {
    _timer?.cancel();

    emit(state.copyWith(seconds: time));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
  }

  void _resetTimer(ResetTimer event, Emitter<StrooptextState> emit) {
    add(StartTimer());
  }

  void _tick(Tick event, Emitter<StrooptextState> emit) {
    if (state.seconds <= 1) {
      _timer?.cancel();

      time = 60;
      add(InitalStropText());
      return;
    }

    emit(state.copyWith(seconds: state.seconds - 1));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
