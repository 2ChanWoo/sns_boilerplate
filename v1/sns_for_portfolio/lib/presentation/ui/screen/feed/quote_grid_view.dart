
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sns_for_portfolio/presentation/bloc/quote_list/quote_list_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/feed/quote_card.dart';

import '../../component/svg_asset.dart';

class QuoteGridView extends StatelessWidget {
  final QuoteListFetchState state;

  const QuoteGridView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemList = state.apiResponse.data?.quotes ?? [];

    return Padding(
      padding: EdgeInsets.all(12),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final quote = itemList[index];

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
      ),
    );
  }
}