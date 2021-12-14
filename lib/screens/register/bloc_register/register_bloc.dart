import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hyperpay_task/export.dart';
import 'package:hyperpay_task/model/shortly_model.dart';
import 'register_events.dart';
import 'register_states.dart';
class RegisterBloc extends Cubit<RegisterStates> {
  AuthenticationService auth;

  RegisterBloc(RegisterStates initialState, this.auth)
      : super(initialState);

  static RegisterBloc get(context) => BlocProvider.of(context);

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
  void userCreate({
      @required String? username,
      @required String? email,
      @required String? phone,
      @required String? uID})
  {
    UserModel model = UserModel(username: username, email: email, phone: phone, uID: uID);
    emit(RegisterCreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit (RegisterAuthState(uID.toString()));
        }).catchError((error){
          print(error.toString());
          emit(RegisterCreateUserErrorsState(error.toString()));
        });
  }
  void registerAuthState(String email, String password, String username, String phone) async {
    emit (RegisterAuthLoadingState());
    auth.register(email.toString(), password.toString())
          .then((value){
        print('The email is : ${value.user!.email}');
        print('The ID is : ${value.user!.uid}');
        userCreate(username: username,email: email,phone: phone,uID: value.user!.uid);

      }).catchError((errors) {
        print(errors.toString());
        emit(ErrorsRegisterState(errors.toString()));
      });

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

// class RegisterBloc extends Bloc<RegisterEvents , RegisterStates>{
//   AuthenticationService auth;
//
//   RegisterBloc(RegisterStates initialState,this.auth)
//       : super(initialState);
//
//   static RegisterBloc get(context) => BlocProvider.of(context);
//
//   @override
//   Stream<RegisterStates> mapEventToState(RegisterEvents event) async*{
//     if (event is RegisterAuthEvent) {
//       String? _email = event.email.toString();
//       String? _password = event.password.toString();
//       yield* _registerAuthState(_email, _password);
//     }
//
//   }
//
//   Stream<RegisterStates> _registerAuthState(String email, String password) async* {
//     String? uID;
//     auth
//         .register(email, password, uID.toString())
//         .then((value) {
//       print('The value of Register In Bloc'+value);
//     }).catchError((errors) {
//       print(errors.toString());
//     });
//     yield RegisterAuthState(uID.toString());
//
//     // FirebaseAuth.instance.createUserWithEmailAndPassword(
//     //     email: email, password: password)
//     //     .then((value) {
//     //   print(value.user!.email);
//     //   print(value.user!.uid);
//     // }).catchError((error) {
//     //   print(error.toString());
//     // });
//
//   }
//
// }