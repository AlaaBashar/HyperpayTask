import 'package:flutter/material.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_bloc.dart';
import 'package:hyperpay_task/utils/SharedPrevrences.dart';
import '../../export.dart';
import 'bloc_login/login_bloc.dart';
import 'bloc_login/login_events.dart';
import 'bloc_login/login_states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget  {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(
      listener: (context, state) {
        if (state is LoginAuthState) {
          CacheHelper.putUID('uID',state.uid.toString())
              .then((value) {
            MainBloc.get(context).getUser(state.uid.toString());
           openNewPage(context, StartScreen(),);

          }).catchError((error){
            print(error.toString());
          });
        }
        if (state is ErrorsLoginState) {
          var error = state.error.toString();
          final snackBar = SnackBar(
            content: Text(error),
            action: SnackBarAction(label: 'Undo', onPressed: () {},),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsHelper.WIGHT,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_sharp),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SafeArea(

            child: LayoutBuilder(
                builder: (_, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(

                      key: _formKey,
                      child: Container(
                        color: ColorsHelper.WIGHT,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: const Text(
                                'Welcome \nBack',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 30.0),
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            TextFieldWidget(
                              icon: Icon(Icons.account_box),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Email must not be empty';
                                }

                              },

                              isObscure: false,
                              hintText: 'enter the email',
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFieldWidget(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Password must not be empty';
                                }

                              },
                              isObscure: true,
                              icon: Icon(Icons.lock),
                              hintText: 'password',
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'Poppins'),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                InkWell(
                                    onTap: onRegister,
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontFamily: 'Poppins'),
                                    )),
                                const Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            state is LoginLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : buttonWidget(
                                    context: context,
                              textOfButton: 'Login',
                              onPressed: onLogin,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  void onRegister() {
    openNewPage(
      context,
      RegisterScreen(),
    );
  }

  void onLogin() {
    String? email = emailController.text.trim();
    String? password = passwordController.text.trim();

    if (_formKey.currentState!.validate())
      ///LoginBloc.get(context).add(LoginAuthEvent(email, password));
      LoginBloc.get(context).loginAuthState(email, password);

  }
}
