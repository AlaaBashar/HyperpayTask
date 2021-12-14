import 'package:equatable/equatable.dart';

abstract class RegisterStates extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterStatesInitialState extends RegisterStates {}
/// FIRE_STORE
class RegisterCreateUserLoadingState extends RegisterStates {}
class RegisterCreateUserSuccessState extends RegisterStates {}
class RegisterCreateUserErrorsState extends RegisterStates {
  final String error;
  RegisterCreateUserErrorsState(this.error);
}
/// FIRE_AUTH

class RegisterAuthLoadingState extends RegisterStates {}
class RegisterAuthState extends RegisterStates {
  final String uid;
  RegisterAuthState(this.uid);
}
class ErrorsRegisterState extends RegisterStates {
  final String error;
  ErrorsRegisterState(this.error);
}
