// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'passcode_event.dart';
part 'passcode_state.dart';

class PasscodeBloc extends Bloc<PasscodeEvent, PasscodeState> {
  PasscodeBloc() : super(PasscodeInitialState()) {
    on<CheckingPassCodeEvent>((event, emit) {
      final now = DateTime.now();
      final num day = now.day, month = now.month, year = now.year;

      final ddmmyyyyfinal = ('${day * month * year}'.length < 6
              ? '${day < 9 ? ('0$day') : '$day'}${month < 9 ? ('0$month') : '$month'}$year'
              : '${day * month * year}')
          .trim();
      if (kDebugMode) {
        print(
          'current code |$state|${event.passcode}| event called with $ddmmyyyyfinal ${ddmmyyyyfinal == event.passcode}',
        );
      }

      if (state is PasscodeInitialState) {
        if (ddmmyyyyfinal == event.passcode) {
          if (kDebugMode) print('current code is correct');
          emit(PasscodeSuccessState(passcode: event.passcode));
        }
        if (ddmmyyyyfinal != event.passcode) {
          if (kDebugMode) print('current code is incorrect');
          emit(PasscodeCheckState(passcode: event.passcode));
        }
      } else {
        if (kDebugMode) {
          print('current code is error ${ddmmyyyyfinal == event.passcode}');
        }

        if (ddmmyyyyfinal == event.passcode) {
          if (kDebugMode) print('current code is correct');
          emit(PasscodeSuccessState(passcode: event.passcode));
        } else {
          if (kDebugMode) print('current code is incorrect');
          emit(PasscodeCheckState(passcode: event.passcode));
        }
      }
    });
    on<RetryPasscodeEvent>((event, emit) {
      if (state is PasscodeCheckState) {
        emit(PasscodeCheckState(passcode: event.passcode));
      }
      emit(PasscodeCheckState(passcode: event.passcode));
    });
  }
}
