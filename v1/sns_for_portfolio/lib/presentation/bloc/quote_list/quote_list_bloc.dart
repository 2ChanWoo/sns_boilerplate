import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/data/provider/network/api_response.dart';
import 'package:sns_for_portfolio/domain/entity/quote_entity.dart';
import 'package:sns_for_portfolio/domain/entity/quote_list_page_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/fetch_quote_list_page_usecase.dart';
import '../../../domain/usecase/usecase.dart';

part 'quote_list_event.dart';

part 'quote_list_state.dart';

class QuoteListBloc extends Bloc<QuoteListEvent, QuoteListState> {
  final FetchQuoteListPageUseCase fetchQuoteListPageUsaCase;
  QuoteListPage? get res => switch(state) {
        // QuoteListFetchState() => state.apiResponse?.data,
        QuoteListFetchState(:final apiResponse) => apiResponse.data,
        _ => () {
            var err = UnimplementedError("Not implemented state(${state.toString()})");
            Log.e(err, StackTrace.current);
            return null;
          }.call()
      };

  QuoteListBloc(this.fetchQuoteListPageUsaCase)
      : super(QuoteListFetchState(
            ApiResponse.completed(const QuoteListPage(page: 0, isLastPage: false, quotes: [])))) {
    on<QuoteListEvent>((event, emit) async {
      Log.i("QuoteListBloc/on()- event: $event");
      switch (event) {
        case QuotePageListFetchEvent():
          await _quoteListPageFetch(emit, event);
        default:
          Log.e(UnimplementedError("Not implemented event(${event.toString()})"), StackTrace.current);
      }
    });
  }

  // Future _quoteListFetch(Emitter emit) async {
  //   Log.i("_quoteListFetch()");
  //   emit(QuoteListFetchState(ApiResponse.loading("_quoteListFetch loading..")));
  //   try {
  //     QuoteListPage response = await fetchQuoteListPageUsaCase.execute();
  //     emit(QuoteListFetchState(ApiResponse.completed(response)));
  //   } catch (e, st) {
  //     Log.e(e, st);
  //     emit(QuoteListFetchState(ApiResponse.error("_quoteListFetch error: $e")));
  //   }
  // }
  Future<void> _quoteListPageFetch(Emitter emit, QuotePageListFetchEvent event) async {
    Log.i("_quotePageListFetch()");
    // emit(QuoteListFetchState(ApiResponse.loading("Quote page fetch:: page: ${event.page}")));
    final pageStream = quotePageStream(event.page);

    await emit.onEach(pageStream, onData: emit);
  }

  Stream<QuoteListState> quotePageStream(int page) async* {
    QuoteListPage response =
        await fetchQuoteListPageUsaCase.execute(FetchQuoteListPageUseCaseParams(page));

    /// repo 메서드도 stream으로??
    ///
    List<Quote> newItemList = response.quotes;
    List<Quote> oldItemList = state.apiResponse?.data?.quotes ?? [];
    List<Quote> completeItemList = [...oldItemList, ...newItemList];

    Log.i("old len: ${oldItemList.length}, new len: ${newItemList.length}, total len: ${completeItemList.length}");

    yield QuoteListFetchState(
      ApiResponse.completed(
        QuoteListPage(
          page: page,   //TODO: 밖에도 뺴야하나? 에러났을 때 제거되면, 마지막 페이지를 알 필요 있어보임. (리스트도 있어야 하니 인스턴스쨰로)
          isLastPage: response.isLastPage,
          quotes: completeItemList,
        ),
      ),
    );
  }
}
