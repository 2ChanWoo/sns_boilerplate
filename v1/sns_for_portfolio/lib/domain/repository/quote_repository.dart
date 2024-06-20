import 'package:sns_for_portfolio/domain/entity/quote_list_page_entity.dart';

abstract class QuoteServiceRepository {
  Future<QuoteListPage> fetchQuoteListPage(String page);
}