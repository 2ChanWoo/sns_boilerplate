// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      id: (json['id'] as num).toInt(),
      body: json['body'] as String?,
      userDetails: json['user_details'] == null
          ? null
          : UserDetails.fromJson(json['user_details'] as Map<String, dynamic>),
      favoritesCount: (json['favorites_count'] as num?)?.toInt() ?? 0,
      upvotesCount: (json['upvotes_count'] as num?)?.toInt() ?? 0,
      downvotesCount: (json['downvotes_count'] as num?)?.toInt() ?? 0,
      author: json['author'] as String?,
    );
