enum HttpMethod {
  get("get"),
  post("post"),
  delete("delete"),
  put("put"),
  patch("patch");

  final String _method;
  const HttpMethod(this._method);
}

abstract class APIRequestRepresentable {
  Map<String, dynamic>? body;

  Uri get url;

  String get endpoint;

  String get path;

  HttpMethod get method;

  Map<String, String>? get headers;

  Map<String, String>? get query;

  Future request();
}
