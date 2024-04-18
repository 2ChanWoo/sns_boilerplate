import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/data/provider/network/api_response.dart';
import 'package:sns_for_portfolio/domain/entity/quote_list_page_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/fetch_quote_list_page_usecase.dart';

part 'quote_list_event.dart';
part 'quote_list_state.dart';

class QuoteListBloc extends Bloc<QuoteListEvent, QuoteListState> {
  final FetchQuoteListPageUseCase fetchQuoteListPageUsaCase;

  QuoteListBloc(this.fetchQuoteListPageUsaCase) : super(QuoteListFetchState(ApiResponse.initial('QuoteListFetch init'))) {
    on<QuoteListEvent>((event, emit) async {
      Log.i("QuoteListBloc/on()- event: $event");
      return switch (event) {
        QuoteListEvent() => _quoteListFetch(emit),
      };
    });
  }

  Future _quoteListFetch(Emitter emit) async {
    Log.i("_quoteListFetch()");
    emit(QuoteListFetchState(ApiResponse.loading("_quoteListFetch loading..")));
    try {
      QuoteListPage response = await fetchQuoteListPageUsaCase.execute();
      emit(QuoteListFetchState(ApiResponse.completed(response)));
    } catch (e, st) {
      Log.e(e, st);
      emit(QuoteListFetchState(ApiResponse.error("_quoteListFetch error: $e")));
    }
  }
}
