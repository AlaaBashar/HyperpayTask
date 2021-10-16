import 'package:equatable/equatable.dart';
import 'package:hyperpay_task/model/shortly_model.dart';

class ShortlyStates extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class InitialState extends ShortlyStates{}
class LoadingState extends ShortlyStates{}

class ErrorState extends ShortlyStates{
 final String message;
  ErrorState(this.message);}

class FetchSuccess extends ShortlyStates{
  final ShortlyModel shortly;
  FetchSuccess(this.shortly);
}
