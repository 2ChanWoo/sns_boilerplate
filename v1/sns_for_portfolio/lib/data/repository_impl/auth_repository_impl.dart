import 'dart:convert';
import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';
import 'package:sns_for_portfolio/data/provider/network/api/auth_service.dart';
import 'package:sns_for_portfolio/domain/repository/auth_repository.dart';

import '../../domain/entity/session_entity.dart';

class AuthRepository_impl extends AuthRepository{
  final BehaviorSubject<Session> _sessionSubject = BehaviorSubject();

  @override
  Future<void> signIn(Map<String, dynamic> body) async {
    final Uint8List response = await AuthService.session({"user": body}).request();
    Session result = Session.fromJson(json.decode(utf8.decode(response)));

    _sessionSubject.add(result);
  }

  @override
  Stream<Session> sessionStream() async*{
   yield* _sessionSubject.stream;
  }
}