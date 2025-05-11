import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sns_for_portfolio/data/repository_impl/auth_repository_impl.dart';
import 'package:sns_for_portfolio/domain/usecase/usecase.dart';

import '../entity/session_entity.dart';
import '../repository/auth_repository.dart';

part 'auth_stream_usecase.g.dart';

class AuthStreamUseCase extends StreamUseCase<Session, void> {
  final AuthRepository _repo;

  AuthStreamUseCase(this._repo);
  @override
  Stream<Session> stream([params]) async* {
    yield* _repo.sessionStream();
  }
}

@riverpod
AuthStreamUseCase authStreamUseCase(Ref ref) {
  return AuthStreamUseCase(ref.watch(authRepositoryProvider));
}