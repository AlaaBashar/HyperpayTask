import 'package:equatable/equatable.dart';
import 'package:hyperpay_task/model/shortly_model.dart';

abstract class ShortlyStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialState extends ShortlyStates {}

class LoadingState extends ShortlyStates {}

class FetchUrlState extends ShortlyStates {
  final ShortlyResult shortly;

  FetchUrlState(
    this.shortly,
  );
}

class ErrorState extends ShortlyStates {
  final String message;

  ErrorState(this.message);
}

class FetchSuccess extends ShortlyStates {
  static String? url;
  final ShortlyResult shortly;

  FetchSuccess(this.shortly);
}
