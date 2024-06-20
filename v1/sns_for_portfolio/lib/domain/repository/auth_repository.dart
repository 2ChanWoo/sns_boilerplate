import '../entity/session_entity.dart';

abstract class AuthRepository {
  Future<void> signIn(Map<String, dynamic> body);

  Stream<Session> sessionStream();
}