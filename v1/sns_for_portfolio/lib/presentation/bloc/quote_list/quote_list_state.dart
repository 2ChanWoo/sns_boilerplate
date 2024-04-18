part of 'quote_list_bloc.dart';

@immutable
abstract class QuoteListState extends Equatable {}

class QuoteListFetchState extends QuoteListState {
  final ApiResponse<QuoteListPage> apiResponse;
  QuoteListFetchState(this.apiResponse);

  @override
  List<Object?> get props => [apiResponse, apiResponse.data];
}
