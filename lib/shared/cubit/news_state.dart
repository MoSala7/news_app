part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsBottomNav extends NewsState {}

class GetBuisnessNewsSuccess extends NewsState {}

class GetNewsBuisnessLoading extends NewsState {}

class GetBuisnessNewsError extends NewsState {
  final String error;
  GetBuisnessNewsError(this.error);
}

class GetScienceNewsSuccess extends NewsState {}

class GetNewsScienceLoading extends NewsState {}

class GetScienceNewsError extends NewsState {
  final String error;
  GetScienceNewsError(this.error);
}

class GetSportsNewsSuccess extends NewsState {}

class GetNewsSportsLoading extends NewsState {}

class GetSportsNewsError extends NewsState {
  final String error;
  GetSportsNewsError(this.error);
}

class GetSearchNewsSuccess extends NewsState {}

class GetNewsSearchLoading extends NewsState {}

class GetSearchNewsError extends NewsState {
  final String error;
  GetSearchNewsError(this.error);
}

class SwithThemeApp extends NewsState {}
