import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyperpay_task/screens/login/login_screen.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_bloc.dart';
import 'package:hyperpay_task/screens/main/bloc_main/main_states.dart';
import '../export.dart';


Future<dynamic> openNewPage(BuildContext context, Widget widget,
    {bool popPreviousPages = false}) {
  return Future<dynamic>.delayed(Duration.zero, () {
    if (!popPreviousPages)
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget,
          settings: RouteSettings(arguments: widget),
        ),
      );
    else
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => widget,
              settings: RouteSettings(
                arguments: widget,
              )),
          (Route<dynamic> route) => false);
  });
}

double getScreenWidth(BuildContext context, {bool realWidth = false}) {

  if (realWidth)
    return MediaQuery.of(context)
        .size
        .width; //to preview widget like phone scale in preview

  if (kIsWeb)
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.width / 4
        : MediaQuery.of(context).size.height / 4;

  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width
      : MediaQuery.of(context).size.height;
}

double getScreenHeight(BuildContext context, {bool realHeight = false}) {
  if (realHeight)
    return MediaQuery.of(context)
        .size
        .height; //to preview widget like phone scale in preview
  if (kIsWeb)
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.height / 1.4
        : MediaQuery.of(context).size.width / 1.4;
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.height
      : MediaQuery.of(context).size.width;
}

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final Icon? icon;
  final FormFieldValidator<String>? validator;

  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.controller, required this.isObscure, this.validator, this.icon,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30.0),
      child: Container(
        height:  50.0,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 10),
            )
          ],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextFormField(

          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            icon:icon ,
              hintText: hintText,
              border: InputBorder.none,
              enabled: true
          ),
          validator:validator
        ),
      ),
    );
  }
}


// class ButtonWidget extends StatelessWidget {
//   final String? textOfButton;
//   final VoidCallback? onPressed;
//   final Color? colorOfButton ;
//   const ButtonWidget({
//     Key? key,
//     this.textOfButton,
//     this.onPressed, this.colorOfButton,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: 50.0, vertical: 30.0),
//       child: MaterialButton(
//         onPressed: onPressed,
//         color: colorOfButton,
//         height: 50,
//         minWidth: getScreenWidth(context, realWidth: true),
//         child: Text(
//           '$textOfButton',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }



Widget buttonWidget({
    double horizontalPadding = 50.0,
    double verticalPadding = 30.0,
    double height = 50.0,
    String? textOfButton,
    VoidCallback? onPressed,
    Color? colorOfButton = ColorsHelper.CYAN ,
    required BuildContext context,

}) => Padding(
  padding:EdgeInsets.symmetric(
      horizontal: horizontalPadding, vertical: verticalPadding),
  child: MaterialButton(
    onPressed: onPressed,
    color: colorOfButton,
    height: height,
    minWidth: getScreenWidth(context, realWidth: true),
    child: Text(
      '$textOfButton',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24.0),
    ),
  ),
);



class ListTileWidget extends StatelessWidget {
  final String? modelData;
  final Icon? icon;
  final String? title;
  final GestureTapCallback? onTap;
  const ListTileWidget({
    Key? key,
    this.modelData, this.icon, this.title, this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        '$title: $modelData',
        style: TextStyle(color: ColorsHelper.WIGHT),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainStates>(
        listener: (context, state) {
          // if (state is LogoutSuccessState) {
          //   openNewPage(context, HomeScreen());
          // }
          // if (state is LogoutErrorsState) {
          //   var error = state.error.toString();
          //   final snackBar = SnackBar(
          //     content: Text(error),
          //     action: SnackBarAction(label: 'Undo', onPressed: () {},),);
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //
          // }
        },
        builder: (context, state) {
          var modelData = MainBloc.get(context).model;
          if (state is MainGetUserSuccessState) {
            return  Drawer(
              child: Container(
                color: ColorsHelper.DARK_VIOLET,
                child: Column(
                  children: [
                    const SizedBox(height: 50.0,),
                    Row(children: [
                      const SizedBox(width: 15.0,),
                      CircleAvatar(radius: 40.0,backgroundColor: ColorsHelper.CYAN,),
                      const Spacer(flex: 1,),
                      Column(children: [
                        Text('${modelData.username}',style: TextStyle(color:ColorsHelper.WIGHT,fontFamily: 'Poppins-Bold',fontSize: 20.0),),
                        Text('${modelData.email}',style: TextStyle(color:ColorsHelper.WIGHT,fontFamily: 'Poppins-Light',fontSize: 15.0),),
                      ],),
                      const Spacer(flex: 3,),
                    ],),
                    const SizedBox(height: 50.0,),
                    ListTileWidget(modelData: modelData.username,title: 'User Name',icon: Icon(Icons.account_box,color: ColorsHelper.CYAN,),),
                    Divider(color: ColorsHelper.WIGHT,),
                    ListTileWidget(modelData: modelData.email,title: 'Email',icon: Icon(Icons.email,color: ColorsHelper.CYAN,),),
                    Divider(color: ColorsHelper.WIGHT,),
                    ListTileWidget(modelData: modelData.uID,title: 'UID',icon: Icon(Icons.lock,color: ColorsHelper.CYAN,),),
                    Divider(color: ColorsHelper.WIGHT,),
                    ListTileWidget(modelData: modelData.phone,title: 'Phone',icon: Icon(Icons.add_ic_call,color: ColorsHelper.CYAN,),),
                    Divider(color: ColorsHelper.WIGHT,),
                    // ListTileWidget(title: 'Logout',icon: Icon(Icons.arrow_back,color: ColorsHelper.CYAN,),
                    //   onTap: (){
                    //     MainBloc.get(context).logOutAuthState();
                    // },),
                    const Spacer(flex: 1,),


                  ],
                ),
              ),
            );
          }
          return Container();
        }


    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}




// class Wrapper extends StatelessWidget {
//   const Wrapper({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final user = AuthenticationService().user;
//       return BlocConsumer<ShortlyBloc, ShortlyStates>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     if (state is LogoutState) {
//       if (state.uID != null) {
//         return StartScreen();
//       }
//
//     }
//     return HomeScreen();
//   },
// );
//
//
//   }
// }




