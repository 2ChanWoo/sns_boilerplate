part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventSignIn(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class AuthEventSignOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class AuthEventStateUpdate extends AuthEvent {
  final Session session;

  const AuthEventStateUpdate(this.session);

  @override
  List<Object?> get props => [session.email, session.login, session.userToken];
}