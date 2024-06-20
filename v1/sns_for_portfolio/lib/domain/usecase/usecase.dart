const Map<String, dynamic> emptyMap = {};

// class Params<T> {
//   T? body;
//   // Map<String, String>? param;
//   Map<String, String>? query;
//   Map<String, String>? path;
//
//   Params({this.body, this.query, this.path});
// }

/// [T] Unboxing 'Response' of [execute]
/// [P] 'Request' parameters of [execute]
abstract class UseCase<T, P> {
  Future<T> execute(P params);
}

/// (Part of override) if not required params~
// Future<QuoteListPage> execute([void _]) async {} //TODO: => is it Non-abstract?

abstract class StreamUseCase<T, P> {
  Stream<T> stream([P params]);
}