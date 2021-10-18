import 'package:equatable/equatable.dart';

 class ShortlyEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoFetchEvents extends ShortlyEvents{}

class FetchUrlEvent extends ShortlyEvents{
  final String? url;

  FetchUrlEvent(this.url);
}