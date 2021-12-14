import 'package:equatable/equatable.dart';

abstract class RegisterEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class RegisterAuthEvent extends RegisterEvents {
  final String? email;
  final String? password;

  RegisterAuthEvent(this.email, this.password);
}