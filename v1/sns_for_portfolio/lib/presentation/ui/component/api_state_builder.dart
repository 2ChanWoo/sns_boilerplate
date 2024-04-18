import 'package:flutter/material.dart';

import '../../../data/provider/network/api_response.dart';
import 'exception_indicator.dart';

typedef CompleteCallback = Widget Function();

Widget apiStateBuilder({
  required ApiStatus status,
  Widget? initial,
  Widget? loading,
  required CompleteCallback completeBuilder,
  Widget? error,
  final VoidCallback? onTryAgain,
}) {
  switch (status) {
    case ApiStatus.INITIAL:
      return initial ?? Center(child: CircularProgressIndicator(color: Colors.grey));
    case ApiStatus.LOADING:
      return loading ?? Center(child: CircularProgressIndicator(color: Colors.black));
    case ApiStatus.COMPLETED:
      return completeBuilder();
    case ApiStatus.ERROR:
      return error ?? ExceptionIndicator(onTryAgain: onTryAgain);
  }
}
