import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sns_for_portfolio/presentation/ui/component/api_state_builder.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/feed/quote_grid_view.dart';

import '../../../bloc/quote_list/quote_list_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QuoteListBloc>().add(QuoteListFetchEvent());

    return Scaffold(
      body: BlocBuilder<QuoteListBloc, QuoteListState>(
        builder: (context, state) {
          return switch (state) {
            QuoteListFetchState() => _fetch(state),
            QuoteListState() => Container()
          };
        },
      ),
    );
  }

  Widget _fetch(QuoteListFetchState state) {
    //TODO: if-QuoteListView; 리스트뷰도 추가할 것.
    return apiStateBuilder(
      status: state.apiResponse.status,
      completeBuilder: () {
        return QuoteGridView(state: state);
      },
    );
  }
}
