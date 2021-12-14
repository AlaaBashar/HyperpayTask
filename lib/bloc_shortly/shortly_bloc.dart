import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_events.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_states.dart';
import 'package:hyperpay_task/model/shortly_model.dart';
import 'package:hyperpay_task/repository/shortly_repository.dart';
import 'package:hyperpay_task/utils/SharedPrevrences.dart';
import '../export.dart';

class ShortlyBloc extends Bloc<ShortlyEvents, ShortlyStates> {
  ShortlyRepository repo;
  AuthenticationService auth;

  ShortlyBloc(ShortlyStates initialState, this.repo, this.auth)
      : super(initialState);

  static ShortlyBloc get(context) => BlocProvider.of(context);

  @override
  Stream<ShortlyStates> mapEventToState(ShortlyEvents event) async* {
    if (event is FetchUrlEvent) {
      yield* _shortlyUrlInToState(event.url.toString());
    }
    if (event is LogOutEvent) {
      yield* _logOutAuthState();
    }
  }

  Stream<ShortlyStates> _shortlyUrlInToState(String url) async* {
    try {
      yield LoadingState();
      ShortlyResult? shortly = await repo.fetchShortlyData(url);
      yield FetchUrlState(shortly!);
    } catch (e) {
      yield ErrorState(e.toString());
    }
  }
  Stream<ShortlyStates> _logOutAuthState() async* {
    auth.logout()
        .then((value) {
      print('User is logout ');
      CacheHelper.putUID('uID', null.toString())
          .then((value) {})
          .catchError((error) {
        print(error.toString());
      });
    }).catchError((error){
      print(error.toString());
    });
    yield LogoutState();
  }
  // Stream<ShortlyStates> _loginAuthState(String email, String password) async* {
  //   String? uID;
  //   auth
  //       .login(email, password, uID.toString())
  //       .then((value) {
  //         print('The value of Login In Bloc'+value);
  //   })
  //       .catchError((errors) {
  //     print(errors.toString());
  //   });
  //   yield LoginAuthState(uID.toString());
  //   // FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
  //   //     .then((value) {
  //   //   print(value.user!.email);
  //   //   print(value.user!.uid);
  //   //   uID = value.user!.uid;
  //   // }).catchError((error) {
  //   //   print(error.toString());
  //   // });
  // }

  // Stream<ShortlyStates> _registerAuthState(String email, String password) async* {
  //   String? uID;
  //   auth
  //       .register(email, password, uID.toString())
  //       .then((value) {
  //     print('The value of Register In Bloc'+value);
  //   }).catchError((errors) {
  //     print(errors.toString());
  //   });
  //   yield RegisterAuthState(uID.toString());
  //
  //   // FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   //     email: email, password: password)
  //   //     .then((value) {
  //   //   print(value.user!.email);
  //   //   print(value.user!.uid);
  //   // }).catchError((error) {
  //   //   print(error.toString());
  //   // });
  //
  // }

}
