import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/presentation/ui/component/api_state_builder.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/feed/quote_grid_view.dart';

import '../../../../domain/entity/quote_entity.dart';
import '../../../bloc/quote_list/quote_list_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PagingController<int, Quote> _pagingController = PagingController(firstPageKey: 1);
  QuoteListBloc get _bloc => context.read<QuoteListBloc>();
  @override
  void initState() {
    Log.i('FeedScreen initState()');
    super.initState();
    _pagingController.addPageRequestListener((pageNumber) {
      _bloc.add(QuotePageListFetchEvent(pageNumber));
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<QuoteListBloc, QuoteListState>(
          listener: (context, state) {
            Log.i(
                "QuoteListBloc listener - state item length: ${state.apiResponse?.data?.quotes.length}");
            // _pagingController.appendPage(state.api|Response!.data!.quotes, _pagingController.value.nextPageKey);
            final stateValue = state.apiResponse?.data;

            /// UI update 는 Quote_~_view/PagedMasonryGridView (infinity scroll widget) 에서 처리됨.
            /// [_pagingController.value] :: ValueNotifier.value
            _pagingController.value = PagingState(
              itemList: stateValue?.quotes,
              nextPageKey: stateValue?.page != null ? stateValue!.page + 1 : 1,
              // error: TODO:
            );
          },
          child: _fetch()),
    );
  }

  Widget _fetch() {
    //TODO: if-QuoteListView; 리스트뷰도 추가할 것.
    return apiStateBuilder(
      status: _bloc.state.apiResponse!.status, //TODO: !
      completeBuilder: () {
        return QuoteGridView(controller: _pagingController);
      },
    );
  }
}
