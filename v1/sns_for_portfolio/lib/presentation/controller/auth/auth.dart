import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sns_for_portfolio/data/repository_impl/auth_repository_impl.dart';
import 'package:sns_for_portfolio/domain/entity/session_entity.dart';
import 'package:sns_for_portfolio/domain/usecase/auth_stream_usecase.dart';
import 'package:sns_for_portfolio/domain/usecase/signin_usecase.dart';

import '../../../app/util/dev_log.dart';

part 'auth.g.dart';

@riverpod
class Auth extends _$Auth {
  late final SignInUseCase _signInUseCase;
  late final AuthStreamUseCase _authStreamUseCase;
  @override
  FutureOr<Session?> build() async {
    _signInUseCase = ref.watch(signInUseCaseProvider);
    _authStreamUseCase = ref.watch(authStreamUseCaseProvider);

    _authStreamUseCase.stream().listen((session) {
      state = AsyncData(session);
    });

    return null;
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    try{
      final session = await _signInUseCase.execute(SignInUseCaseParams(
        email,
        password,
      ));
    } catch (e, st) {
      Log.e(e, st);
      state = AsyncError(e, st);
    }
  }
}
