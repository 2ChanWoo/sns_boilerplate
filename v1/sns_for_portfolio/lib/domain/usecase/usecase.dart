const Map<String, dynamic> emptyMap = {};

abstract class UseCase<T> {
  Future<T> execute({Map<String, dynamic> body = emptyMap, Map<String, dynamic> path = emptyMap});
}

abstract class StreamUseCase<T> {
  Stream<T> stream({Map<String, dynamic> param = emptyMap});
}