import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sns_for_portfolio/data/repository_impl/auth_repository_impl.dart';
import 'package:sns_for_portfolio/domain/entity/session_entity.dart';
import 'package:sns_for_portfolio/domain/repository/auth_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/usecase.dart';

part 'signin_usecase.g.dart';

class SignInUseCase extends UseCase<void, SignInUseCaseParams> {
  final AuthRepository _repo;
  SignInUseCase(this._repo);
  
  @override
  Future execute(SignInUseCaseParams params) async {
    await _repo.signIn(params.toJson());
  }
}

class SignInUseCaseParams {
  final String login;
  final String password;
  
  SignInUseCaseParams(this.login, this.password);

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }}

@riverpod
SignInUseCase signInUseCase (Ref ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}