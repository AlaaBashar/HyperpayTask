import 'package:firebase_auth/firebase_auth.dart';
import 'package:hyperpay_task/export.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_bloc.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Cubit<LoginStates> {
  AuthenticationService auth;

  LoginBloc(LoginStates initialState, this.auth)
      : super(initialState);

  static LoginBloc get(context) => BlocProvider.of(context);

// @override
// Stream<LoginStates> mapEventToState(LoginEvents event) async*{
//   if (event is LoginAuthEvent) {
//     String? _email = event.email.toString();
//     String? _password = event.password.toString();
//     yield* _loginAuthState(_email, _password);
//   }
//
// }

//   Stream<LoginStates> loginAuthState(String email, String password) async* {
//     String? uID;
//     String? error;
//     var test=  LoginAuthState(uID.toString());
//
//       // auth.login(email.toString(), password.toString(), uID.toString())
//       //     .then((value) async*{
//       //   print('The value of Login In Bloc' + value);
//       //   yield LoginAuthState(uID.toString());
//       // }).catchError((errors) {
//       //   print(errors.toString());
//       // });
//      try {
//       await FirebaseAuth.instance
//            .signInWithEmailAndPassword(
//            email: email.toString(), password: password.toString())
//            .then((value) {
//              print('The email is : ${value.user!.email}');
//              print('The ID is : ${value.user!.uid}');
//        }).catchError((errors){
//         print('error is ');
//         error=errors.toString();
//         print(error.toString());
//       });
//       if (error!.isEmpty) {
//         yield ErrorsLoginState(error.toString());
//       }
//
//
//      } catch(error){
//       /// yield ErrorsLoginState(error.toString());
//        print('error is : '+error.toString());
//      }
//
//
//   }
//
//
// }

   void loginAuthState(String email, String password) async {
    String? uID;

    emit(LoginLoadingState());
    auth
        .login(email.toString(), password.toString(),)
        .then((value) {
      print('The email is : ${value.user!.email}');
      print('The ID is : ${value.user!.uid}');
      emit(LoginAuthState(value.user!.uid.toString()));
    }).catchError((errors) {
      print(errors.toString());
      emit(ErrorsLoginState(errors.toString()));
    });

    // auth.login(email.toString(), password.toString(), uID.toString())
     //     .then((value) async*{
     //   print('The value of Login In Bloc' + value);
     //   yield LoginAuthState(uID.toString());
     // }).catchError((errors) {
     //   print(errors.toString());
     // });

     //  FirebaseAuth.instance
     //     .signInWithEmailAndPassword(
     //     email: email.toString(), password: password.toString())
     //     .then((value) {
     //   print('The email is : ${value.user!.email}');
     //   print('The ID is : ${value.user!.uid}');
     //   emit(LoginAuthState(uID.toString()));
     // }).catchError((error){
     //   print('errors is : ');
     //   emit(ErrorsLoginState(error.toString()));
     // });

  }


}


