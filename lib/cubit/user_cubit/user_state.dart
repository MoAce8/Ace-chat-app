part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserGotInfo extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {}
