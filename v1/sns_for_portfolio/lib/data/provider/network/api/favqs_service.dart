import 'package:sns_for_portfolio/app/util/extension.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum FavQsServiceUrlQueryKey {
  page;

}

enum FavQsServiceType {

  /// POST
  quotes("/quotes");

  final String _path;

  const FavQsServiceType(this._path);

  String get path => _path;
}

class FavQsService implements APIRequestRepresentable {
  final FavQsServiceType type;

  final String? page;

  FavQsService._({required this.type, this.body, this.page});
  FavQsService.getQuoteListPage({String? page}): this._(type: FavQsServiceType.quotes, page: page);

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
  String get query {
    /// Uri(queryParameters: ~)
    /// queryParameters, Map<String, dynamic> 이지만, value에 int 넣으면 에러
    ///
    /// ㄴ> 타입에 주석으로 /*String?|Iterable<String>*/ 라고 되어 있음. 두 경우만 가능한 것 같다.
    ///
    /// Uri(queryParameters: {'asd': ['1','2','3']}).toString()
    /// == "asd=1&asd=2&asd=3
    return switch (type) {
      FavQsServiceType.quotes => Uri(queryParameters: {
          FavQsServiceUrlQueryKey.page.name: page,
        }).toString()
    };

    // final Map<String, String?> queryMap = switch (type) {
    //   FavQsServiceType.quotes => {
    //       FavQsServiceUrlQueryKey.page.name: page,
    //     }
    // };
    //
    // return Uri().toQueryString(queryMap);
  }

  @override
  Future request() {
    return ApiProvider.instance.request(this);
  }

  @override
  Uri get url {
    return Uri.parse(endpoint + path + query);
  }
}
