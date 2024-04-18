import 'package:json_annotation/json_annotation.dart';

part 'user_details_entity.g.dart';

@JsonSerializable(createToJson: false)
class UserDetails {
  const UserDetails({
    required this.favorite,
    required this.upvote,
    required this.downvote,
  });

  @JsonKey(name: 'favorite')
  final bool favorite;
  @JsonKey(name: 'upvote')
  final bool upvote;
  @JsonKey(name: 'downvote')
  final bool downvote;

  static const fromJson = _$UserDetailsFromJson;
}
