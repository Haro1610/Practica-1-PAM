part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

@immutable
abstract class QuotState {}

class QuoteInitial extends QuoteState {}

class QuoteSuccess extends QuoteState {
  final Map successMsg;
  QuoteSuccess({required this.successMsg, auttor});

  @override
  List<Object> get props => [successMsg];
}

class QuoteError extends QuoteState {
  final String errorMsg;
  QuoteError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
