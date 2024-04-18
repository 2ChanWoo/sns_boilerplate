
import 'package:flutter/material.dart';

import '../../../app/router/router.dart';
import '../../../app/util/dev_log.dart';
import '../../../app/util/snackbar.dart';
import 'api_exception.dart';

class ApiResponse<T> {
  ApiStatus status;
  T? data;
  String? message;

  dynamic error;

  ApiResponse.initial(this.message) : status = ApiStatus.INITIAL {
    if (message != null) Log.i("ApiResponse.initial >> ${message!}");
  }

  ApiResponse.loading(this.message) : status = ApiStatus.LOADING {
    if (message != null) Log.i("ApiResponse.loading >> ${message!}");
  }

  ApiResponse.completed(this.data) : status = ApiStatus.COMPLETED {
    if (message != null) Log.i("ApiResponse.completed >> ${message!}");
  }

  ApiResponse.error(this.message, {bool snackExcept = false, this.error}): status = ApiStatus.ERROR {
    if (message != null) Log.i("ApiResponse.error >> ${message!}");

    if (!snackExcept && error is FetchDataException && rootNavigatorKey.currentContext != null) {
      showSnackBar(
        rootNavigatorKey.currentContext!,
        Text("Something went wrong (ApiResponse.error)"),
        duration: const Duration(seconds: 10),
        showCloseIcon: true,
      );
    }

    // if(!snackExcept && !(e is DuplicatedRequestException)) {
    //   Get.closeAllSnackbars();
    //   Get.snackbar.dart("Failed", message ?? "");
    // }
  }

  @override
  String toString() {
    return "Status : $status \nMessage : $message \nData : $data";
  }
}

/// ApiStatus { INITIAL, LOADING, COMPLETED, ERROR }
enum ApiStatus { INITIAL, LOADING, COMPLETED, ERROR }