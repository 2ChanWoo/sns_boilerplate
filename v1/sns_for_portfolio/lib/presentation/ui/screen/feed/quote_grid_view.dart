import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sns_for_portfolio/presentation/bloc/quote_list/quote_list_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/feed/quote_card.dart';

import '../../../../domain/entity/quote_entity.dart';
import '../../component/svg_asset.dart';

class QuoteGridView extends StatelessWidget {
  final PagingController<int, Quote> controller;

  const QuoteGridView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(12),
      child: PagedMasonryGridView.count(
        pagingController: controller,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        builderDelegate: PagedChildBuilderDelegate<Quote>(
          itemBuilder: (context, quote, index) {
            final isFavorite = quote.userDetails?.favorite ?? false;
            return QuoteCard(
              statement: quote.body ?? '',
              author: quote.author,
              isFavorite: isFavorite,
              top: const OpeningQuoteSvgAsset(),
              bottom: const ClosingQuoteSvgAsset(),
              onFavorite: () {
                // bloc.add(
                //   isFavorite
                //       ? QuoteListItemUnfavorited(quote.id)
                //       : QuoteListItemFavorited(quote.id),
                // );
              },
              onTap: () {},
            );
          },
          // TODO: firstPageErrorIndicatorBuilder:
        ),
      ),
    );
  }
}
