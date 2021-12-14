import 'package:equatable/equatable.dart';
abstract class LoginEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class LoginAuthEvent extends LoginEvents {
  final String? email;
  final String? password;

  LoginAuthEvent(this.email, this.password);
}

