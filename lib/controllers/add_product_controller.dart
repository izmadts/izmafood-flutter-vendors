import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker imagePicker = ImagePicker();
  final productImageFile = Rxn<File>();
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
  final barCodeController = TextEditingController();
  final productTitleController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final salePriceController = TextEditingController();
  final offerPriceController = TextEditingController();
  final wholeSaleController = TextEditingController();
  final listOfPrice = RxList<TextEditingController>();
  final listOfStock = RxList<TextEditingController>();
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
    listOfPrice.clear();
    listOfStock.clear();
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
        for (var element in attributeValueListModel.value?.data ?? []) {
          listOfPrice.add(TextEditingController());
          listOfStock.add(TextEditingController());
        }
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

  // Helpers for Register Page Two image picking
  Future<void> showShopImageSourceDialog() async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                _pickShopImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                _pickShopImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickShopImage(ImageSource source) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        final file = File(image.path);
        productImageFile.value = file;
      }
    } catch (e) {
      handleControllerExceptions(e);
    }
  }

  Future<void> uploadProductImage({
    required File image,
  }) async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      Map<String, dynamic> formDataMap = {
        // 'product_name': productTitleController.text.trim(),
        // 'product_description': productDescriptionController.text.trim(),
        // 'sale_price': salePriceController.text.trim(),
        // 'offer_price': offerPriceController.text.trim(),
        // 'whole_sale': wholeSaleController.text.trim(),
      };
      print('formDataMap: ${jsonEncode(formDataMap)}');
      // Add photo as MultipartFile if image is selected

      if (productImageFile.value != null) {
        formDataMap['photo'] = await dio.MultipartFile.fromFile(
          productImageFile.value!.path,
          filename: productImageFile.value!.path.split('/').last,
        );
      }

      dio.FormData formData = dio.FormData.fromMap(formDataMap);

      final response = await APIHelper().request(
        url: 'seller/product/create',
        method: Method.POST,
        token: token?['token'],
        params: {
          'image': image.path,
        },
      );
      return response.data;
    } catch (e) {
      handleControllerExceptions(e);
    }
  }
}
