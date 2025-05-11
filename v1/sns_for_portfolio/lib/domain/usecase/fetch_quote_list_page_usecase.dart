import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sns_for_portfolio/data/repository_impl/quote_repository_impl.dart';
import 'package:sns_for_portfolio/domain/repository/quote_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/usecase.dart';

import '../entity/quote_list_page_entity.dart';

part 'fetch_quote_list_page_usecase.g.dart';


class FetchQuoteListPageUseCase implements UseCase<QuoteListPage, FetchQuoteListPageUseCaseParams>{
  final QuoteServiceRepository repo;
  FetchQuoteListPageUseCase(this.repo);

  @override
  execute(FetchQuoteListPageUseCaseParams params) async {
    int page = params.page;
    return await repo.fetchQuoteListPage(page.toString());
  }
}
class FetchQuoteListPageUseCaseParams {
  int page;
  FetchQuoteListPageUseCaseParams(this.page);
}

@riverpod
FetchQuoteListPageUseCase fetchQuoteListPageUseCase(Ref ref) {
  return FetchQuoteListPageUseCase(ref.watch(quoteServiceRepositoryProvider));
}