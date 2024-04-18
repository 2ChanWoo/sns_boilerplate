
import 'package:json_annotation/json_annotation.dart';
import 'package:sns_for_portfolio/domain/entity/user_details_entity.dart';

part 'quote_entity.g.dart';

@JsonSerializable(createToJson: false)
class Quote {
  const Quote({
    required this.id,
    required this.body,
    required this.userDetails,
    required this.favoritesCount,
    required this.upvotesCount,
    required this.downvotesCount,
    this.author,
  });

  final int id;
  final String? body;
  final String? author;
  @JsonKey(name: 'user_details')
  /// 로그인이 된 경우에만 값이 존재함.
  final UserDetails? userDetails;
  @JsonKey(name: 'favorites_count', defaultValue: 0)
  final int favoritesCount;
  @JsonKey(name: 'upvotes_count', defaultValue: 0)
  final int upvotesCount;
  @JsonKey(name: 'downvotes_count', defaultValue: 0)
  final int downvotesCount;

  // static const fromJson = _$QuoteFromJson;
  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}
