import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sns_for_portfolio/app/util/extension.dart';

import '../../../app/util/dev_log.dart';
import 'api_env.dart';
import 'api_exception.dart';
import 'api_request_representable.dart';

class ApiProvider {
  ApiProvider() {
    const appTokenEnvironmentVariableKey = 'fav-qs-app-token';
    const appToken = String.fromEnvironment(
      appTokenEnvironmentVariableKey,
    );

    _apiHeader = {
      'Content-Type': "application/json",
      'Authorization': 'Token token=$appToken',
    };
  }

  static final ApiProvider _singleton = ApiProvider();

  static ApiProvider get instance => _singleton;

  static const requestTimeOut = Duration(seconds: 10);

  late Map<String, String> _apiHeader;

  //TODO: AuthBloc 에서 종속되어있음. 괜찮은가?
  void setHeader(Map<String, String> additionalHeaders) {
    Log.i("setHeader +$additionalHeaders");
    _apiHeader.addAll(additionalHeaders);
  }

  //TODO: 요청별이 아닌, 연속해서 같은 요청이 지정된 시간 안에 들어올 경우만 필터링 된다.
  String preRequestUrl = '';
  DateTime preRequestTimestamp = DateTime.now();

  /// [isRepeated] ㅈㅐ귀 요청에서 탈출하기위한 변수.
  Future<Uint8List> request(APIRequestRepresentable req, {bool isRepeated = false}) async {
    if (req.url.toString() == preRequestUrl) {
      if (DateTime.now().difference(preRequestTimestamp) <= Duration(milliseconds: 100)) {
        Log.i(
            "같은 요청이 100ms 안에 다시 요청되었습니다. 요청을 취소합니다. 요청 주소: ${req.url.toString()} // time: $preRequestTimestamp");
        throw DuplicatedRequestException("Duplicated request: ${req.url.toString()}");
      }
    }

    preRequestUrl = req.url.toString();
    preRequestTimestamp = DateTime.now();

    late http.Response res;

    if (!req.headers.isNullOrEmpty) {
      _apiHeader.addAll(req.headers!);
    }

    Log.d(
        "\n\$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ New Request \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$\n");
    // Log.d("http_log request additional Header << ${req.headers}}");
    Log.d("[${req.method.name}] http_log Header << ${req.url} $_apiHeader");
    // Log.d("http_log requestBody <<  ${req.body}");

    var body = jsonEncode(req.body);

    try {
      switch (req.method) {
        case HttpMethod.post:
          res = await http.post(
            req.url,
            body: body,
            headers: _apiHeader,
          );
          break;

        case HttpMethod.put:
          res = await http.put(
            req.url,
            body: body,
            headers: _apiHeader,
          );
          break;

        case HttpMethod.get:
          res = await http.get(
            req.url,
            //body: req.body,
            headers: _apiHeader,
          );
          break;

        case HttpMethod.delete:
          res = await http.delete(
            req.url,
            body: body,
            headers: _apiHeader,
          );
          break;

        case HttpMethod.patch:
          res = await http.patch(
            req.url,
            body: body,
            headers: _apiHeader,
          );
          break;
      }

      // 오류보고에 불필요한 도메인 필터링. 단, 디버그모드에서는 출력한다.
      if (!(_exceptUrlFilter(res.request?.url.toString())) /*|| kDebugMode*/) {
        // Log.d("\n\$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ New Request \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$ \$\n");
        // Log.i("#### [${res.request?.method}] Request Info << ${res.request?.url}");
        Log.d("Request header ${res.request?.headers}");
        Log.d("Request body $body");
        Log.d("=========================================================start");
        Log.d("http_log responseHeader << ${res.headers}");
        Log.i("http_log responseBody <<  ${utf8.decode(res.bodyBytes)}");
        Log.d("=========================================================end");
      }

      return requestTail(res);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on UnauthorisedException {
      try {
        if (!isRepeated) {
          Log.i("인증 오류 발생, 토큰 재발급 후 재요청 >>>>>>");

          /// ///////////////////////////////////////////////////////// await AuthRepositoryImpl().refreshToken();
          return await request(req, isRepeated: true);
        }
        throw UnauthorisedException('Token expiration');
      } catch (e) {
        throw UnauthorisedException('Token expiration');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }

  Uint8List requestTail(http.Response res) {
    if (res.statusCode == 400) {
      throw BadRequestException("HttpRequest requestTail 400 error");
    } else if (res.statusCode == 401) {
      throw UnauthorisedException("HttpRequest requestTail 401 error");
    } else if (res.statusCode == 404) {
      throw NotFoundException("HttpRequest requestTail 404 error");
    } else if (res.statusCode == 409) {
      throw ConflictException("HttpRequest requestTail 409 error");
    } else if (res.statusCode == 204) {
      throw NoContentsException("HttpRequest requestTail 204");
    } else if (res.statusCode ~/ 100 == 2) {
      return res.bodyBytes;
    } else if (res.statusCode ~/ 100 == 3) {
      throw Exception("HttpRequest requestTail 3xx error");
    } else if (res.statusCode ~/ 100 == 4) {
      throw Exception("HttpRequest requestTail 4xx error");
    } else if (res.statusCode ~/ 100 == 5) {
      throw InternalServerErrorException("HttpRequest requestTail 5xx error");
    } else {
      throw Exception("HttpRequest requestTail etc error");
    }
  }

  /// 예외로 설정한 url이라면 true 반환.
  bool _exceptUrlFilter(String? url) {
    if (url.isNullOrEmpty) return false;
    if (url!.contains("BlahBlahBlahBlah")) return true;

    return false;
  }
}

/// ssl 오류 부분을 다 신뢰로 바꾸는 작업으로 추정됨.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
