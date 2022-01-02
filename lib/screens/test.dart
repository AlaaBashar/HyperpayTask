import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_bloc.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_events.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_states.dart';
import 'package:hyperpay_task/database_shortly/database_helper.dart';
import 'package:hyperpay_task/database_shortly/model_database.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String? short;
  String? origin;
  DbHelper? helper;
  List? user;
  late ShortlyBloc bloc;
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    helper = DbHelper();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocConsumer<ShortlyBloc, ShortlyStates>(
              listener: (context,state){},
                builder: (context, state) {
              if (state is LoadingState) {
                return CircularProgressIndicator();
              } else if (state is FetchUrlState)
              {
                return Text('${state.shortly.shortLink}');
              } else if (state is ErrorState) {
                return Text(
                  state.message,
                  textAlign: TextAlign.center,
                );
              }

              return SizedBox();
            }),
          ),

          TextField(
            controller: urlController,
          ),
          Text('-------------------------------'),
          MaterialButton(
            onPressed: onCreate,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  void onCreate() async {


    ///ShortlyBloc.get(context).add(FetchUrlEvent(urlController.text));

    ///ShortlyBloc.get(context).add(FetchUrlEvent(urlController.text));


  }
}

