import 'dart:convert';
import 'dart:typed_data';

import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/data/provider/network/api/favqs_service.dart';
import 'package:sns_for_portfolio/domain/repository/favqs_repository.dart';

import '../../domain/entity/quote_list_page_entity.dart';

class FavQsServiceRepository_impl implements FavQsServiceRepository {
  @override
  Future<QuoteListPage> fetchQuotes() async {
    Log.i("fetchQuotes()");
    final Uint8List response = await FavQsService.getQuotes().request();
    return QuoteListPage.fromJson(jsonDecode(utf8.decode(response)));
  }
}