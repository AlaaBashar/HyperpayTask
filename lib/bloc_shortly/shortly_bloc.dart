import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_events.dart';
import 'package:hyperpay_task/bloc_shortly/shortly_states.dart';
import 'package:hyperpay_task/model/shortly_model.dart';
import 'package:hyperpay_task/repository/shortly_repository.dart';
import '../export.dart';

class ShortlyBloc extends Bloc<ShortlyEvents,ShortlyStates>{
  ShortlyRepository repo;

  ShortlyBloc(ShortlyStates initialState,this.repo) : super(initialState);

  static ShortlyBloc get(context) =>BlocProvider.of(context);

  @override
  Stream<ShortlyStates> mapEventToState(ShortlyEvents event) async*{
    if(event is DoFetchEvents){

      try{
        yield LoadingState();
        ShortlyResult? shortly = await repo.fetchShortlyData(FetchSuccess.url.toString());
        yield FetchSuccess(shortly!);
      }
      catch(e){
        yield ErrorState(e.toString());}}

    if(event is FetchUrlEvent){
      print('-----------------------------${event.url}');
      try{
        yield LoadingState();
        ShortlyResult? shortly = await repo.fetchShortlyData(event.url.toString());
        yield FetchUrlState(shortly!);

      }catch(e){
        yield ErrorState(e.toString());
      }
    }


  }
}