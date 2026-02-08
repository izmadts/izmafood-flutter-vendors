import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/attribute_model.dart'
    as attribute_model;
import 'package:izma_foods_vendor/models/attribute_value_model.dart'
    as attribute_value_model;
import 'package:izma_foods_vendor/models/brands_list_model.dart';
import 'package:izma_foods_vendor/models/category_model.dart';
// import 'package:izma_foods_vendor/models/product_list_model.dart'
//     as product_list_model;

class AddProductController extends GetxController {
  final brandListModel = Rxn<BrandListModel>();
  final selectedBrand = Rxn<Datum>();
  final categoryListModel = Rxn<CategoryModel>();
  final selectedCategory = Rxn<SubCategory>();
  final isLoading = false.obs;
  final attributeListModel = Rxn<attribute_model.AttributeModel>();
  final selectedAttribute = Rxn<attribute_model.Datum>();
  final selectedAttributeValue = ''.obs;
  final attributeValueListModel =
      Rxn<attribute_value_model.AttributeValueModel>();
  final selectedAttributeValueItem = Rxn<attribute_value_model.Datum>();
  final isAttributeSelected = false.obs;
  final stocksAvailable = true.obs;
  onInit() {
    super.onInit();
    getBrandList();
    getCategories();
    getAddOns();
  }

  getBrandList() async {
    final token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        method: Method.GET,
        url: 'seller/brands',
        token: token?['token'],
      );
      brandListModel.value = BrandListModel.fromJson(response.data);
      if (brandListModel.value?.status == true) {
        isLoading(false);
        showSnackBar('Brand list fetched successfully');
      } else {
        isLoading(false);
        throw APIException(
          message: 'Failed to fetch brand list',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  getCategories() async {
    final item =
        // Get.find<AuthController>()
        //     .loginModel
        //     .value
        //     ?.data
        //     ?.user
        //     ?.shop
        //     ?.shopCategory
        3;
    try {
      final response = await APIHelper().request(
        url: 'subcategory/$item',
        method: Method.GET,
      );
      print("testing: ${response.data}");
      categoryListModel.value = CategoryModel.fromJson(response.data);
      if (categoryListModel.value?.status == 'true') {
        showSnackBar('Categories fetched successfully');
      } else {
        throw APIException(
          message: 'Failed to fetch categories',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    }
  }

  getAddOns() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        url: 'seller/attributes',
        token: token?['token'],
        method: Method.GET,
      );
      attributeListModel.value =
          attribute_model.AttributeModel.fromJson(response.data);
      if (attributeListModel.value?.status == true) {
        isLoading(false);
        showSnackBar('Attribute list fetched successfully');
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

  Future<void> attributeValue(attribute_model.Datum value) async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isAttributeSelected(true);
      final response = await APIHelper().request(
        url: 'seller/attributes/${value.id}',
        token: token?['token'],
        method: Method.GET,
      );
      attributeValueListModel.value =
          attribute_value_model.AttributeValueModel.fromJson(response.data);
      if (attributeValueListModel.value?.status == true) {
        isAttributeSelected(false);
        showSnackBar('Attribute value list fetched successfully');
      } else {
        isAttributeSelected(false);
        throw APIException(
          message: 'Failed to fetch attribute value list',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isAttributeSelected(false);
    }
  }
}
