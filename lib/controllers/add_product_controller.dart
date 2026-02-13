import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/controllers/splash_controller.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/add_product_model.dart';
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
  final isProductAdded = false.obs;
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
  final splashController = Get.find<SplashController>();
  final listIdsForAttributes = RxList<int>();
  final productAddedModel = Rxn<ProductAddedModel>();
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
    listIdsForAttributes.clear();
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
          if (element.id != null) {
            listIdsForAttributes.add(element.id!);
          }
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

  Future<void> createProduct() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    var errorMessage = isValidate();
    if (errorMessage.isNotEmpty) {
      showSnackBar(errorMessage);
      return;
    } else {
      try {
        isProductAdded(true);
        final attributeData = attributeValueListModel.value?.data ?? [];
        var variantCount = attributeData.length;
        if (listIdsForAttributes.length < variantCount) {
          variantCount = listIdsForAttributes.length;
        }
        if (listOfPrice.length < variantCount) {
          variantCount = listOfPrice.length;
        }
        if (listOfStock.length < variantCount) {
          variantCount = listOfStock.length;
        }

        final variantIds = <String>[];
        final variantValues = <String>[];
        final variantPrices = <String>[];
        final variantStocks = <String>[];

        for (var i = 0; i < variantCount; i++) {
          variantIds.add(selectedAttributeValue.value.toString());
          variantValues.add(attributeData[i].comment ?? '');

          final priceText = listOfPrice[i].text.trim();
          variantPrices.add(priceText.isEmpty ? '0' : priceText);

          final stockText = listOfStock[i].text.trim();
          variantStocks.add(stockText.isEmpty ? '0' : stockText);
        }

        final hasVariants = variantIds.isNotEmpty;

        Map<String, dynamic> formDataMap = {
          'title': productTitleController.text.trim(),
          'stock': stocksAvailable.value ? '3' : '5',
          'subcategory': selectedCategory.value?.id,
          'cat_id':
              splashController.userInfoModel.value?.data?.shop?.shopCategory,
          'rprice': offerPriceController.text.trim(),
          'sprice': salePriceController.text.trim(),
          'wprice': wholeSaleController.text.trim(),
          'variable_product': hasVariants ? '1' : '0',
          'barcode': barCodeController.text.trim(),
          'summary': productDescriptionController.text.trim(),
          'is_featured': 'no',
          'brand_id': selectedBrand.value?.id,
        };

        if (hasVariants) {
          formDataMap['add_produt_id'] = selectedAttributeValue.value;
          formDataMap['add_produt_value[]'] = variantValues;
          formDataMap['price[]'] = variantPrices;
          formDataMap['quantity[]'] = variantStocks;
          formDataMap['add_produt_id[]'] = variantIds;
        }
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
          params: formData,
        );
        print('response create product: ${response.data}');
        productAddedModel.value = ProductAddedModel.fromJson(response.data);
        isProductAdded(false);
        if (productAddedModel.value?.status == true) {
          showSnackBar('Product added successfully');
        } else if (productAddedModel.value?.status == false) {
          showSnackBar(
              productAddedModel.value?.errors ?? 'Failed to add product');
        }
      } catch (e) {
        isProductAdded(false);
        print('error create product: ${e.toString()}');
        // showSnackBar(e.toString());
        handleControllerExceptions(e);
      }
    }
  }

  String isValidate() {
    if (productTitleController.text.isEmpty ||
        productTitleController.text == '') {
      return 'Please enter product title';
    }
    if (productDescriptionController.text.isEmpty ||
        productDescriptionController.text == '') {
      return 'Please enter product description';
    }
    if (selectedBrand.value == null) {
      return 'Please select brand';
    }
    if (selectedCategory.value == null) {
      return 'Please select category';
    }
    if (productImageFile.value == null) {
      return 'Please select product image';
    }
    if (salePriceController.text.isEmpty || salePriceController.text == '') {
      return 'Please enter sale price';
    }
    if (offerPriceController.text.isEmpty || offerPriceController.text == '') {
      return 'Please enter offer price';
    }
    if (wholeSaleController.text.isEmpty || wholeSaleController.text == '') {
      return 'Please enter whole sale price';
    }
    return '';
  }
}
