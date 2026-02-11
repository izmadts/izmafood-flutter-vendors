import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/controllers/splash_controller.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/dash_board_model.dart';

class DashBoardController extends GetxController {
  final dashBoardModel = Rxn<DashBoardModel>();
  final isLoading = false.obs;
  final isLoadingShopName = false.obs;
  final splashController = Get.find<SplashController>();
  final shopName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDashBoard();
  }

  Future<void> getShopName() async {
    isLoadingShopName(true);
    shopName.value =
        splashController.userInfoModel.value?.data?.shop?.shopName ?? '';
    print('shopName: ${shopName.value}');
    isLoadingShopName(false);
  }

  getDashBoard() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();

    try {
      isLoading(true);
      await getShopName();
      final response = await APIHelper().request(
        url: 'seller/dashboard',
        token: token?['token'],
        method: Method.GET,
      );
      dashBoardModel.value = DashBoardModel.fromJson(response.data);
      if (dashBoardModel.value?.status == true) {
        isLoading(false);
        showSnackBar('Dashboard fetched successfully');
      } else {
        isLoading(false);
        throw APIException(
          message: 'Failed to fetch dashboard',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }
}
