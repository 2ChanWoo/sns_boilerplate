import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/data/provider/network/api_response.dart';
import 'package:sns_for_portfolio/domain/entity/session_entity.dart';
import 'package:sns_for_portfolio/domain/usecase/signin_usecase.dart';

import '../../../domain/usecase/usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //TODO: validate ( with formz package )
  final UseCase<void, SignInUseCaseParams> _signInUseCase;
  final StreamUseCase<Session, void> _authStreamUseCase;

  AuthBloc(this._signInUseCase, this._authStreamUseCase) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEventSignIn():
          await _signIn(emit, event);
          break;
        case AuthEventSignOut():
          await _signOut(emit);
          break;
        case AuthEventStateUpdate():
          _update(emit, event);
          break;
      }
    });

    _authStreamUseCase.stream().listen((session) {
      add(AuthEventStateUpdate(session));
    });
  }

  _update(Emitter<AuthState> emit, AuthEventStateUpdate event) {
    emit(AuthStateSigned(ApiResponse.completed(event.session)));
  }

  Future<void> _signIn(Emitter<AuthState> emit, AuthEventSignIn event) async {
    emit(AuthStateSigned(ApiResponse.loading("_signIn()")));

    try{
      final session = await _signInUseCase.execute(SignInUseCaseParams(
        event.email,
        event.password,
      ));
    } catch (e, st) {
      Log.e(e, st);
      emit(AuthStateSigned(ApiResponse.error("_signIn()", error: e)));
    }
  }

  Future<void> _signOut(Emitter<AuthState> emit) async {
    emit(const AuthStateSignOuted());
  }
}
