part of 'countryflags_bloc.dart';

@immutable
abstract class CountryflagsState {}

class CountryflagsInitial extends CountryflagsState {}

class CountryflagsSuccess extends CountryflagsState {
  final Map successMsg;
  CountryflagsSuccess({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}

class CountryflagsError extends CountryflagsState {
  final String errorMsg;
  CountryflagsError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
