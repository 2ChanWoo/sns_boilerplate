import 'dart:convert';
import 'dart:typed_data';

import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/data/provider/network/api/quote_service.dart';
import 'package:sns_for_portfolio/domain/repository/quote_repository.dart';

import '../../domain/entity/quote_list_page_entity.dart';

class QuoteServiceRepository_impl implements QuoteServiceRepository {
  @override
  Future<QuoteListPage> fetchQuoteListPage(String page) async {
    Log.i("fetchQuotes()");
    final Uint8List response = await QuoteService.getQuoteListPage(page: page).request();
    return QuoteListPage.fromJson(jsonDecode(utf8.decode(response)));
  }
}