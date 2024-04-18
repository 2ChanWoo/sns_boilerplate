import 'package:json_annotation/json_annotation.dart';
import 'package:sns_for_portfolio/domain/entity/quote_entity.dart';

part 'quote_list_page_entity.g.dart';

@JsonSerializable(createToJson: false)
class QuoteListPage {
  const QuoteListPage({
    required this.page,
    required this.isLastPage,
    required this.quotes,
  });

  final int page;
  @JsonKey(name: 'last_page')
  final bool isLastPage;
  final List<Quote> quotes;

  static const fromJson = _$QuoteListPageFromJson;
}
