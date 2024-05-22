import 'package:sns_for_portfolio/domain/entity/quote_list_page_entity.dart';

abstract class FavQsServiceRepository {
  Future<QuoteListPage> fetchQuotes(String page);
}