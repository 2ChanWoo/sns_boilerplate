import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum FavQsServiceType {

  /// POST
  quotes("/quotes");

  final String _path;

  const FavQsServiceType(this._path);

  String get path => _path;
}

class FavQsService implements APIRequestRepresentable {
  final FavQsServiceType type;

  FavQsService._({required this.type, this.body});
  FavQsService.getQuotes(): this._(type: FavQsServiceType.quotes);

  @override
  Map<String, dynamic>? body;

  @override
  String get endpoint => ApiEndpoint.FavQsService.baseUrl;

  @override
  Map<String, String>? get headers => null;

  @override
  HttpMethod get method {
    switch(type) {
      case FavQsServiceType.quotes:
        return HttpMethod.get;
    }
  }

  @override
  String get path {
    switch(type) {
      case FavQsServiceType.quotes:
        return FavQsServiceType.quotes.path;
    }
  }

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return ApiProvider.instance.request(this);
  }

  @override
  Uri get url => Uri.parse(endpoint + path);
}
