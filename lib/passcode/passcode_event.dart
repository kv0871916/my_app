part of 'passcode_bloc.dart';

abstract class PasscodeEvent extends Equatable {
  const PasscodeEvent();

  @override
  List<Object> get props => [];
}

class CheckingPassCodeEvent extends PasscodeEvent {
  const CheckingPassCodeEvent({required this.passcode});
  final String passcode;

  @override
  List<Object> get props => [passcode];
}

class RetryPasscodeEvent extends PasscodeEvent {
  const RetryPasscodeEvent({required this.passcode});
  final String passcode;

  @override
  List<Object> get props => [passcode];
}
