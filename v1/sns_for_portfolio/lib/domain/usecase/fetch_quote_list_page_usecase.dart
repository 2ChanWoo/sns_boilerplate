import 'package:sns_for_portfolio/domain/repository/favqs_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/usecase.dart';

import '../entity/quote_list_page_entity.dart';

class FetchQuoteListPageUseCase implements UseCase<QuoteListPage, FetchQuoteListPageUseCaseParams>{
  final FavQsServiceRepository repo;
  FetchQuoteListPageUseCase(this.repo);

  @override
  execute(FetchQuoteListPageUseCaseParams params) async {
    int page = params.page;
    return await repo.fetchQuotes(page.toString());
  }
}
class FetchQuoteListPageUseCaseParams {
  int page;
  FetchQuoteListPageUseCaseParams(this.page);
}