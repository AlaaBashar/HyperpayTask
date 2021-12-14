import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_task/export.dart';
import 'package:hyperpay_task/model/shortly_model.dart';
import 'package:hyperpay_task/repository/shortly_repository.dart';
import 'package:hyperpay_task/screens/home/home_screen.dart';
import 'package:hyperpay_task/screens/login/bloc_login/login_states.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_bloc.dart';
import 'package:hyperpay_task/screens/register/bloc_register/register_bloc.dart';
import 'package:hyperpay_task/screens/register/bloc_register/register_states.dart';
import 'package:hyperpay_task/utils/SharedPrevrences.dart';
import 'bloc_shortly/shortly_bloc.dart';
import 'bloc_shortly/shortly_states.dart';
import 'screens/login/bloc_login/login_bloc.dart';
import 'screens/main/bloc_main/main_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  ///----------------------------------------
  Widget widget;
  String? uid = CacheHelper.getUID('uID');
  if (uid != null) {widget = MainScreen();}
  else {widget = HomeScreen();}
  ///----------------------------------------
  runApp(MyApp(widget,uid));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  final String? uid;

  MyApp(this.widget, this.uid);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<ShortlyBloc> (create: (context) => ShortlyBloc (InitialState(), ShortlyRepository(), AuthenticationService()),),
        BlocProvider<LoginBloc>   (create: (context) => LoginBloc   (LoginInitialState(), AuthenticationService())),
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(RegisterStatesInitialState(), AuthenticationService())),
        BlocProvider<MainBloc>    (create: (context) => MainBloc    (MainInitialState(), UserModel(),AuthenticationService())..getUser(uid)),


      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            cardColor: Colors.white,
            cardTheme: CardTheme(
                elevation: 0.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                )),
            textTheme: TextTheme(
              bodyText2: TextStyle(
                fontSize: 17.0,
                fontFamily: 'Poppins-Light',
              ),
            )),
        home: widget,
        //StartScreen(),
      ),
    );
  }
}
