import 'package:equatable/equatable.dart';

abstract class MainStates extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class MainInitialState extends MainStates {}
class MainGetUserSuccessState extends MainStates {}
class MainGetUserLoadingState extends MainStates {}
class MainGetUserErrorsState extends MainStates {
  final String error;
  MainGetUserErrorsState(this.error);
}

class LogoutSuccessState extends MainStates{}
class LogoutErrorsState extends MainStates{
  final String? error;

  LogoutErrorsState(this.error);
}
