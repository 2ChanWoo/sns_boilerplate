import 'package:sns_for_portfolio/app/util/extension.dart';

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

  String get query;

  Future request();
}

// extension ToExtension on Uri {
//   //TODO: refactoring
//   String toQueryString(Map<String, String?> query) {
//     String queryParamStr = '';
//     if (query.hasValue) {
//       query.forEach((key, value) {
//         if (value != null && value.hasValue) queryParamStr += '$key=${value.toString()}&';
//       });
//
//       // 마지막에 & 제거
//       if (queryParamStr.endsWith('&')) {
//         queryParamStr = queryParamStr.substring(0, queryParamStr.length - 1);
//       }
//     }
//
//     if(queryParamStr.isNotEmpty) {
//       queryParamStr = '?$queryParamStr';
//     }
//
//     return queryParamStr;
//   }
// }
