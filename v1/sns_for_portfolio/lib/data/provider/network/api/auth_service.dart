import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum AuthServiceType {

  /// POST
  session("/session");

  final String _path;

  const AuthServiceType(this._path);

  String get path => _path;
}

class AuthService implements APIRequestRepresentable {
  final AuthServiceType type;

  AuthService._({required this.type, this.body});
  AuthService.session(Map<String, dynamic>? body): this._(type: AuthServiceType.session, body: body);

  @override
  Map<String, dynamic>? body;

  @override
  String get endpoint => ApiEndpoint.FavQsService.baseUrl;

  @override
  Map<String, String>? get headers => null;

  @override
  HttpMethod get method {
    switch(type) {
      case AuthServiceType.session:
        return HttpMethod.post;
    }
  }

  @override
  String get path {
    switch(type) {
      case AuthServiceType.session:
        return AuthServiceType.session.path;
    }
  }

  @override
  String get query => '';

  @override
  Future request() {
    return ApiProvider.instance.request(this);
  }

  @override
  Uri get url {
    return Uri.parse(endpoint + path + query);
  }
}
