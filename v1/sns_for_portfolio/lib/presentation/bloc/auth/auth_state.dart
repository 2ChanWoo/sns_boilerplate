part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthStateInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthStateSigned extends AuthState {
  final ApiResponse<Session> response;

  const AuthStateSigned(this.response);

  @override
  List<Object?> get props => [response, response.status, response.data];
}

final class AuthStateSignOuted extends AuthState {
  const AuthStateSignOuted();

  @override
  List<Object?> get props => [];
}