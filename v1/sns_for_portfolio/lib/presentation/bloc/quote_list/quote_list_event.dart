part of 'quote_list_bloc.dart';

@immutable
abstract class QuoteListEvent {}

class QuotePageListFetchEvent extends QuoteListEvent {
  final int page;
  QuotePageListFetchEvent(this.page);
}
