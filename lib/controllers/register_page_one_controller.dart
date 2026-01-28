import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPageOneController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  // Form controllers
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable state
  final selectedGender = 'Male'.obs;
  final selectedDateOfBirth = Rx<DateTime?>(null);
  final selectedImage = Rx<File?>(null);

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.onClose();
  }

}
