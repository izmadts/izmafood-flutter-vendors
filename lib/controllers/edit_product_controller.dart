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
import 'package:izma_foods_vendor/models/edit_product_model.dart';
// import 'package:izma_foods_vendor/models/product_list_model.dart'
//     as product_list_model;

class EditProductController extends GetxController {
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
  final splashController = Get.find<SplashController>();
  final productId = 0.obs;
  final arguments = Get.arguments;
  final isProductAdded = false.obs;
  final productAddedModel = Rxn<ProductAddedModel>();
  final listIdsForAttributes = RxList<int>();
  final productEditModel = Rxn<ProductEditModel>();
  final productPhotoUrl = ''.obs;

  onInit() {
    super.onInit();
    productId.value = arguments?['productId'] ?? 0;
    print('productId: ${productId.value}');
    _loadEditData();
  }

  Future<void> _loadEditData() async {
    isLoading(true);
    try {
      await Future.wait<void>([
        getProductDetails(),
        getBrandList(),
        getCategories(),
        getAddOns(),
      ]);
      assignEditDataToForm();
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  getProductDetails() async {
    final token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      final response = await APIHelper().request(
        method: Method.GET,
        url: 'seller/product/${productId.value}',
        token: token?['token'],
      );
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        productEditModel.value = ProductEditModel.fromJson(resData);
      }
      if (productEditModel.value?.status != true) {
        throw APIException(
          message: 'Failed to fetch product details',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
      rethrow;
    }
  }

  Future<void> assignEditDataToForm() async {
    final data = productEditModel.value?.data;
    if (data == null) return;

    barCodeController.text = data.barcode ?? '';
    productTitleController.text = data.title ?? '';
    productDescriptionController.text = data.summary ?? '';
    salePriceController.text = data.sprice ?? '';
    offerPriceController.text = data.rprice ?? '';
    wholeSaleController.text = data.wprice ?? '';

    final stockVal = data.stockAvailable;
    stocksAvailable.value = stockVal == '1' ||
        stockVal == 1 ||
        stockVal == true ||
        stockVal == 'true';

    productPhotoUrl.value = data.photo ?? '';

    final brandId = data.brandId;
    if (brandId != null && brandListModel.value?.data != null) {
      for (final b in brandListModel.value!.data!) {
        if (b.id.toString() == brandId.toString()) {
          selectedBrand.value = b;
          break;
        }
      }
    }

    final subCatId = data.subCatId;
    if (subCatId != null && categoryListModel.value?.subCategory != null) {
      for (final c in categoryListModel.value!.subCategory!) {
        if (c.id.toString() == subCatId.toString()) {
          selectedCategory.value = c;
          break;
        }
      }
    }

    if (data.variableProduct == '1' &&
        (data.attributePrices?.isNotEmpty ?? false)) {
      await _assignAttributeData(data);
    }
  }

  Future<void> _assignAttributeData(Data data) async {
    final firstAttr = data.attributePrices!.first;
    final attrId = firstAttr.attributeId;
    if (attrId == null || attributeListModel.value?.data == null) return;

    attribute_model.Datum? attribute;
    for (final a in attributeListModel.value!.data!) {
      if (a.id.toString() == attrId.toString()) {
        attribute = a;
        break;
      }
    }
    if (attribute == null) return;

    selectedAttribute.value = attribute;
    selectedAttributeValue.value = attribute.id.toString();
    await attributeValue(attribute);

    final attrPrices = data.attributePrices!;
    final attrValues = attributeValueListModel.value?.data ?? [];
    for (var i = 0;
        i < attrValues.length &&
            i < listOfPrice.length &&
            i < listOfStock.length;
        i++) {
      final valComment = (attrValues[i].comment ?? '').toLowerCase();
      for (final ap in attrPrices) {
        if ((ap.attributeVlue ?? '').toString().toLowerCase() == valComment) {
          listOfPrice[i].text = ap.price ?? '0';
          listOfStock[i].text = ap.quantity ?? '0';
          break;
        }
      }
    }
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
          if (element.id != null) listIdsForAttributes.add(element.id!);
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

      final response = await APIHelper().request(
        url: 'seller/product/create',
        method: Method.POST,
        token: token?['token'],
        params: {'image': image.path},
      );
      return response.data;
    } catch (e) {
      handleControllerExceptions(e);
    }
  }

  Future<void> updateProduct() async {
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
          'id': productId.value,
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
          // 'id': productId.value,
        };

        if (hasVariants) {
          formDataMap['add_produt_id'] = selectedAttributeValue.value;
          formDataMap['add_produt_value[]'] = variantValues;
          formDataMap['price[]'] = variantPrices;
          formDataMap['quantity[]'] = variantStocks;
          formDataMap['add_produt_id[]'] = listIdsForAttributes.isNotEmpty
              ? listIdsForAttributes.map((id) => id.toString()).toList()
              : variantIds;
        }
        print('formDataMap: ${jsonEncode(formDataMap)}');

        // Add photo as MultipartFile only if user picked a new image
        if (productImageFile.value != null) {
          formDataMap['photo'] = await dio.MultipartFile.fromFile(
            productImageFile.value!.path,
            filename: productImageFile.value!.path.split('/').last,
          );
        }

        dio.FormData formData = dio.FormData.fromMap(formDataMap);

        final response = await APIHelper().request(
          url: 'seller/products/update',
          method: Method.POST,
          token: token?['token'],
          params: formData,
        );
        print('response update product: ${response.data}');
        productAddedModel.value = ProductAddedModel.fromJson(response.data);
        isProductAdded(false);
        if (productAddedModel.value?.status == true) {
          showSnackBar('Product updated successfully');
          // Get.back();
        } else if (productAddedModel.value?.status == false) {
          showSnackBar(
              productAddedModel.value?.errors ?? 'Failed to update product');
        }
      } catch (e) {
        isProductAdded(false);
        print('error update product: ${e.toString()}');
        showSnackBar(e.toString().contains('Exception')
            ? 'Failed to update product'
            : e.toString());
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
    if (productImageFile.value == null && productPhotoUrl.value.isEmpty) {
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
