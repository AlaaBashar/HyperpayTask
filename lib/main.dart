import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_task/export.dart';
import 'package:hyperpay_task/repository/shortly_repository.dart';
import 'package:hyperpay_task/screens/test.dart';

import 'bloc_shortly/shortly_bloc.dart';
import 'bloc_shortly/shortly_states.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: BlocProvider(
        create: (context) => ShortlyBloc(InitialState(), ShortlyRepository()),
        child: Test(),
      ),

      //StartScreen(),
    );
  }
}
