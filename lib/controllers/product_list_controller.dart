import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/product_list_model.dart';

class ProductListController extends GetxController {
  final productListModel = Rxn<ProductListModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  getProductList() async {
    final item =
        // Get.find<AuthController>()
        //     .loginModel
        //     .value
        //     ?.data
        //     ?.user
        //     ?.shop
        //     ?.shopCategory
        4;
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        url: 'seller/products?categories=$item',
        token: token?['token'],
        method: Method.GET,
      );
      productListModel.value = ProductListModel.fromJson(response.data);
      if (productListModel.value?.status == true) {
        isLoading(false);
        showSnackBar('Product list fetched successfully');
      } else {
        isLoading(false);
        throw APIException(
          message: 'Failed to fetch product list',
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
