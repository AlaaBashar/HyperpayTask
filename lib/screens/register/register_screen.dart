import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyperpay_task/screens/login/login_screen.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_bloc.dart';
import 'package:hyperpay_task/utils/SharedPrevrences.dart';
import '../../export.dart';
import 'bloc_register/register_bloc.dart';
import 'bloc_register/register_events.dart';
import 'bloc_register/register_states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController    = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterAuthState) {
          CacheHelper.putUID('uID', state.uid.toString())
              .then((value) {
            MainBloc.get(context).getUser(state.uid.toString());
            openNewPage(
              context,
              StartScreen(),
            );


          }).catchError((error) {
            print(error.toString());
          });
        }
        if (state is RegisterCreateUserErrorsState) {
          var error = state.error.toString();
          final snackBar = SnackBar(
            content: Text(error),
            action: SnackBarAction(label: 'Undo', onPressed: () {},),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
        else if (state is ErrorsRegisterState) {
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
            child: LayoutBuilder(builder: (_, constraints) {
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
                                'Create \nUser',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 30.0),
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            TextFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'User name must not be empty';
                                }
                              },
                              icon: Icon(Icons.account_box),
                              isObscure: false,
                              hintText: 'User Name',
                              controller: usernameController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email address must not be empty';
                                }
                              },
                              icon: Icon(Icons.email),
                              isObscure: false,
                              hintText: 'Email Address',
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password must not be empty';
                                }
                              },
                              icon: Icon(Icons.lock),
                              isObscure: true,
                              hintText: 'Password',
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone must not be empty';
                                }
                              },
                              icon: Icon(Icons.add_ic_call),
                              isObscure: false,
                              hintText: 'Phone',
                              controller: phoneController,
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
                                    onTap: onLogin,
                                    child: const Text(
                                      'Login',
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
                            state is RegisterAuthLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : buttonWidget(
                                    textOfButton: 'Register',
                                    onPressed: onRegister,
                                    context: context,
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

  void onLogin() {
    openNewPage(
      context,
      LoginScreen(),
    );
  }

  void onRegister() {
    String? email = emailController.text.trim();
    String? password = passwordController.text.trim();
    String? username = usernameController.text.trim();
    String? phone = phoneController.text.trim();
    if (_formKey.currentState!.validate())
      RegisterBloc.get(context).registerAuthState(email,password,username,phone) ;
  }
}
