import 'package:sns_for_portfolio/domain/repository/favqs_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/usecase.dart';

import '../entity/quote_list_page_entity.dart';

class FetchQuoteListPageUseCase implements UseCase{
  final FavQsServiceRepository repo;
  FetchQuoteListPageUseCase(this.repo);

  @override
  Future<QuoteListPage> execute({Map<String, dynamic> body = emptyMap, Map<String, dynamic> path = emptyMap}) async {
    return await repo.fetchQuotes();
  }
}