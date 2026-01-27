import 'package:logger/logger.dart';

extension Log on Object {
  // print statement used for responses and normal printing
  void logInfo() {
    Logger().d(this);
  }

  // print statement used for error logging
  void logError() {
    Logger().e(this);
  }

  // print statement used for failed situations
  void logFailure() {
    Logger().e(this);
  }

  // print statement used for warning situations
  void logWarn() {
    Logger().w(this);
  }
}
