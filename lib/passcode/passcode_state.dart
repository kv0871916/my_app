part of 'passcode_bloc.dart';

abstract class PasscodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class PasscodeInitialState extends PasscodeState {
  @override
  List<Object> get props => [];
}

class PasscodeCheckState extends PasscodeState {
  PasscodeCheckState({required this.passcode});
  final String passcode;
  @override
  List<Object> get props => [passcode];
}

class PasscodeSuccessState extends PasscodeState {
  PasscodeSuccessState({required this.passcode});
  final String passcode;
  @override
  List<Object> get props => [passcode];
}

class PasscodeErrorState extends PasscodeState {
  PasscodeErrorState();

  @override
  List<Object> get props => [];
}
