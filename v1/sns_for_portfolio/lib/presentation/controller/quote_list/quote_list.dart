import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/data/repository_impl/quote_repository_impl.dart';
import 'package:sns_for_portfolio/domain/entity/quote_list_page_entity.dart';

import '../../../domain/entity/quote_entity.dart';
import '../../../domain/usecase/fetch_quote_list_page_usecase.dart';

part 'quote_list.g.dart';

@riverpod
class QuoteList extends _$QuoteList {
  late final FetchQuoteListPageUseCase _fetchQuoteListPageUseCase;

  @override
  FutureOr<QuoteListPage> build() async {
    _fetchQuoteListPageUseCase = ref.watch(fetchQuoteListPageUseCaseProvider);

    return const QuoteListPage(page: 0, isLastPage: false, quotes: []);
  }

  Future<void> fetchNextPage(int page) async {
    state = const AsyncLoading();

    try {
      QuoteListPage response = await _fetchQuoteListPageUseCase.execute(FetchQuoteListPageUseCaseParams(page));

      List<Quote> newItemList = response.quotes;
      List<Quote> oldItemList = state.value?.quotes ?? [];
      List<Quote> completeItemList = [...oldItemList, ...newItemList];

      state = AsyncData(QuoteListPage(
        page: page,
        isLastPage: response.isLastPage,
        quotes: completeItemList,
      ));
    } catch(e, st) {
      Log.e(e, st);
      state = AsyncError(e, st);
    }
  }
}

class Counter extends Notifier<int> {
  @override
  int build() {
    return 0;
  }
}

