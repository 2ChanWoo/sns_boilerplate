extension CheckValues<T> on T {
  bool get hasValue => !(this == null ||
      ((this is String && (this as String).isEmpty) ||
          (this is List && (this as List).isEmpty) ||
          (this is Map && (this as Map).isEmpty)));

  bool get isNullOrEmpty => (this == null ||
      ((this is String && (this as String).isEmpty) ||
          (this is List && (this as List).isEmpty) ||
          (this is Map && (this as Map).isEmpty)));
}

/// from getUtils
extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
