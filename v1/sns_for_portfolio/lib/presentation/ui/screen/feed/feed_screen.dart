import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_for_portfolio/app/util/dev_log.dart';
import 'package:sns_for_portfolio/presentation/controller/quote_list/quote_list.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/feed/quote_grid_view.dart';

import '../../../../domain/entity/quote_entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final PagingController<int, Quote> _pagingController = PagingController(firstPageKey: 1);
  @override
  void initState() {
    Log.i('FeedScreen initState()');
    super.initState();
    _pagingController.addPageRequestListener((pageNumber) {
      Log.i('_pagingController.addPageRequestListener page: $pageNumber');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(quoteListProvider.notifier).fetchNextPage(1);
      });
    });

    ref.listenManual(quoteListProvider, (prev, next) {
      Log.i("ref.listenManual prev: $prev, next: $next");
      if(next is AsyncData && next.value!.page > 0) {
        _pagingController.value = PagingState(
        itemList: next.value?.quotes,
        nextPageKey: next.value?.page != null ? next.value!.page + 1 : 1,
      );
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(quoteListProvider);

    return Scaffold(
        body: QuoteGridView(controller: _pagingController),
    );
  }
}
