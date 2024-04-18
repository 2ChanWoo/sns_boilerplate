// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_list_page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteListPage _$QuoteListPageFromJson(Map<String, dynamic> json) =>
    QuoteListPage(
      page: json['page'] as int,
      isLastPage: json['last_page'] as bool,
      quotes: (json['quotes'] as List<dynamic>)
          .map((e) => Quote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
