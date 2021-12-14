import 'package:equatable/equatable.dart';



abstract class LoginStates extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginAuthState extends LoginStates {
  final String? uid;
  LoginAuthState(this.uid);
}
class ErrorsLoginState extends LoginStates {
  final String error;
  ErrorsLoginState(this.error);
}

