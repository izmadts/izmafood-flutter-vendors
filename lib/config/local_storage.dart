import 'package:get_storage/get_storage.dart';

final String sKeyToken = 'token';

class LocalStorageHelper {
  static storageAutInfo({required String token}) async {
    GetStorage box = GetStorage();
    await box.write(sKeyToken, token);
  }

  static Future<Map<String, dynamic>?> getAuthInfoFromStorage() async {
    try {
      GetStorage box = GetStorage();
      var data = {
        'token': box.read(sKeyToken)!,
      };
      return data;
    } catch (e) {
      return null;
    }
  }
}
