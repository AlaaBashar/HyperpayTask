import 'package:equatable/equatable.dart';
import 'package:hyperpay_task/export.dart';

 abstract class ShortlyEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoFetchEvents extends ShortlyEvents{}
class LogOutEvent extends ShortlyEvents{}

class FetchUrlEvent extends ShortlyEvents{
  final String? url;
  FetchUrlEvent(this.url);
 }

// class LoginAuthEvent extends ShortlyEvents {
//     final String? email;
//     final String? password;
//
//    LoginAuthEvent(this.email, this.password);
// }
// class RegisterAuthEvent extends ShortlyEvents {
//     final String? email;
//     final String? password;
//
//     RegisterAuthEvent(this.email, this.password);
// }


