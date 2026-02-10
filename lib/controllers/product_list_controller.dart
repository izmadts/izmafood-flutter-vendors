import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/category_model.dart';
import 'package:izma_foods_vendor/models/new_base_model.dart';
import 'package:izma_foods_vendor/models/product_list_model.dart';

class ProductListController extends GetxController {
  final productListModel = Rxn<ProductListModel>();
  final listOfTextEditingControllers = RxList<TextEditingController>();
  final isLoading = false.obs;
  final newBaseModel = Rxn<NewBaseModel>();
  final categoriesModel = Rxn<CategoryModel>();
  final selectedCategoryLoading = false.obs;
  // final isSelectedCategory = 0.obs;
  final selectedCategory = Rxn<SubCategory>();
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategories();
    });
  }

  searchProduct(String search, int? id) async {
    print('calling this search');
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        url: 'seller/products?categories=$id&search=$search',
        token: token?['token'],
        method: Method.GET,
      );
      productListModel.value = ProductListModel.fromJson(response.data);
      if (productListModel.value?.status == true) {
        for (var element in productListModel.value?.data?.data ?? []) {
          listOfTextEditingControllers
              .add(TextEditingController(text: element.rprice ?? '0'));
        }
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

  getProductList(int? id) async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        url: 'seller/products?categories=$id',
        token: token?['token'],
        method: Method.GET,
      );
      productListModel.value = ProductListModel.fromJson(response.data);
      final originalList = productListModel.value?.data?.data ?? [];
      originalList.sort((a, b) {
        final aIsOne = a.isAdded == '1';
        final bIsOne = b.isAdded == '1';

        if (aIsOne == bIsOne) return 0;
        return aIsOne ? -1 : 1;
      });

      if (productListModel.value?.status == true) {
        listOfTextEditingControllers.clear();
        for (var element in originalList) {
          listOfTextEditingControllers
              .add(TextEditingController(text: element.rprice ?? '0'));
        }
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

  Future<void> addProduct(int index, String text, int? id) async {
    final token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      final response = await APIHelper().request(
        url: 'seller/product/quick_add',
        method: Method.POST,
        params: {
          'product_id': id,
          'rprice': text,
        },
        token: token?['token'],
      );
      newBaseModel.value = NewBaseModel.fromJson(response.data);
      if (newBaseModel.value?.status == true) {
        showSnackBar('Product added successfully');
      await  getProductList(selectedCategory.value?.id);
      } else {
        throw APIException(
          message: 'Failed to add product',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    }
  }

  getCategories() async {
    final item = 3
        // Get.find<AuthController>()
        //     .loginModel
        //     .value
        //     ?.data
        //     ?.user
        //     ?.shop
        //     ?.shopCategory
        ;
    print("testing: $item");
    try {
      selectedCategoryLoading(true);
      final response = await APIHelper().request(
        url: 'subcategory/$item',
        method: Method.GET,
      );
      print("testing: ${response.data}");
      categoriesModel.value = CategoryModel.fromJson(response.data);
      if (categoriesModel.value?.status == 'true') {
        selectedCategory.value = categoriesModel.value?.subCategory?.first;
        showSnackBar(
            'Categories fetched successfully ${selectedCategory.value?.id}');
        selectedCategoryLoading(false);
        await getProductList(selectedCategory.value?.id);
      } else {
        selectedCategoryLoading(false);
        throw APIException(
          message: 'Failed to fetch categories',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      selectedCategoryLoading(false);
    }
  }
}
