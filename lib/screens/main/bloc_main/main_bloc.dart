import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hyperpay_task/export.dart';
import 'package:hyperpay_task/model/shortly_model.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_states.dart';
import 'package:hyperpay_task/utils/SharedPrevrences.dart';

class MainBloc extends Cubit<MainStates>{
  MainBloc(MainStates initialState,this.model,this.auth) : super(initialState);

static MainBloc get(context) => BlocProvider.of(context);

  UserModel model;
  AuthenticationService auth;

  void getUser(String? uID) {
    emit(MainGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .get()
        .then((value) {
      print('Data is : ');
      print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(MainGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(MainGetUserErrorsState(error.toString()));
    });
  }

  void logOutAuthState()   {
   FirebaseAuth.instance.signOut().then((value) {
     emit(LogoutSuccessState());
   }).catchError((error){
     emit(LogoutErrorsState(error.toString()));
     print(error.toString());

   });


    // auth.logout()
    //     .then((value) {
    //   print('User is logout ');
    //   CacheHelper.putUID('uID','')
    //       .then((value) {
    //         emit(LogoutSuccessState());
    //   })
    //       .catchError((error) {
    //     print(error.toString());
    //   });
    // }).catchError((error){
    //   emit(LogoutErrorsState(error.toString()));
    //   print(error.toString());
    //
    // });
  }





}