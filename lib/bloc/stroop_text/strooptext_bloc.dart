import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/logics/stroop_logic.dart';
import 'package:games/models/stroop_model.dart';
import 'package:games/services/hive_service.dart';

part 'strooptext_event.dart';
part 'strooptext_state.dart';

class StrooptextBloc extends Bloc<StrooptextEvent, StrooptextState> {
  StrooptextBloc() : super(StrooptextState()) {
    on<Solved>(_solved);
    on<InitalStropText>(_inital);
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
      (index, list) = StroopLogic().generateNew();

      emit(
        state.copyWith(
          correctValueIndex: index,
          optionsList: list,
          scoreText: state.scoreText + 10,
          scoreEffect: state.scoreEffect + 10,
        ),
      );
    } else {
      add(InitalStropText());
    }
  }

  FutureOr<void> _inital(InitalStropText event, Emitter<StrooptextState> emit) {
    int selctedValue = 0;
    List<int> list = [];
    (selctedValue, list) = StroopLogic().generateNew();
    StroopModel stroopModel = hiveService.getDataFormBox(box: hiveService.stroopBox);
    emit(
      StrooptextState(
        correctValueIndex: selctedValue,
        optionsList: list,
        scoreText: 0,
        targetScoreText: stroopModel.stropTextMaxScore,
        scoreEffect: 0,
        targetScoreEffect: stroopModel.stropEffectMaxScore,
      ),
    );
  }
}
