import 'package:sns_for_portfolio/domain/usecase/usecase.dart';

import '../entity/session_entity.dart';
import '../repository/auth_repository.dart';

class AuthStreamUseCase extends StreamUseCase<Session, void> {
  final AuthRepository _repo;

  AuthStreamUseCase(this._repo);
  @override
  Stream<Session> stream([params]) async* {
    yield* _repo.sessionStream();
  }
}