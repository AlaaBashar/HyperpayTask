import 'package:flutter/material.dart';
import 'package:hyperpay_task/screens/login/login_screen.dart';

import '../../export.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 3,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Welcome in\nshortly',
              style: TextStyle(
                  fontFamily: 'Poppins-Bold', fontSize: 30.0),
            ),
          ),
          const Spacer(flex: 1,),
          buttonWidget(textOfButton: 'Login',onPressed: onLogin,context: context),
          buttonWidget(
            verticalPadding: 0,
              textOfButton: 'Register',
              onPressed: onRegister,
              context: context,
              colorOfButton: ColorsHelper.DARK_VIOLET),
          const Spacer(flex: 1,),


        ],
      ),
    );

  }

  void onLogin()
  {
    openNewPage(context,LoginScreen(),);
  }

  void onRegister()
  {
  openNewPage(context,RegisterScreen(),);
  }
}
