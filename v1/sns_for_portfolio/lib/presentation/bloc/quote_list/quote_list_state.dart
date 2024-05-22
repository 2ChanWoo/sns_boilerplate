part of 'quote_list_bloc.dart';

@immutable
abstract class QuoteListState extends Equatable {
  ApiResponse<QuoteListPage>? get apiResponse;
}

class QuoteListFetchState extends QuoteListState {
  @override
  final ApiResponse<QuoteListPage> apiResponse;
  QuoteListFetchState(this.apiResponse);

  @override
  List<Object?> get props => [apiResponse, apiResponse.data];
}
