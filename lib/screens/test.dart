import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_bloc.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_events.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_states.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late ShortlyBloc bloc;



  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ShortlyBloc>(context);
    bloc.add(DoFetchEvents());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<ShortlyBloc, ShortlyStates>(
          builder: (context,state) {
            if (state is InitialState) {
              return CircularProgressIndicator();
            }
            else if (state is LoadingState) {
              return CircularProgressIndicator();
            }
            else if (state is FetchSuccess) {
              return Text('hjjjhj');
            }
            else if (state is ErrorState) {
              return ErrorWidget(state.message.toString());
            }
             return SizedBox();
          }
        ),
      ),
    );
  }
}
