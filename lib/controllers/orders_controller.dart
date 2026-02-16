import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/live_order_tracking_model.dart'
    show Cancelled, LiveOrderTrackingModel;
import 'package:izma_foods_vendor/models/update_order_status_model.dart';

class OrdersController extends GetxController {
  final selectedOrderStatus = 'Pending'.obs;
  final liveOrderTrackingModel = Rxn<LiveOrderTrackingModel>();
  final isLoading = false.obs;
  final orderId = ''.obs;
  final orderStausModel = Rxn<UpdateOrderStatusModel>();

  static const orderStatuses = [
    'Pending',
    'Confirmed',
    'Delivered',
    'Dispatched',
    'Cancelled',
  ];

  List<Cancelled> get currentOrders {
    final model = liveOrderTrackingModel.value;
    if (model == null) return [];
    switch (selectedOrderStatus.value) {
      case 'Pending':
        return model.pending ?? [];
      case 'Confirmed':
        return model.confirmed ?? [];
      case 'Delivered':
        return model.delivered ?? [];
      case 'Dispatched':
        return model.dispatched ?? [];
      case 'Cancelled':
        return model.cancelled ?? [];
      default:
        return model.pending ?? [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future<void> getOrders() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        url: 'seller/order/live',
        method: Method.GET,
        token: token?['token'],
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        liveOrderTrackingModel.value = LiveOrderTrackingModel.fromJson(data);
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptOrder() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      final response = await APIHelper().request(
        url: 'seller/orders/status/update',
        method: Method.POST,
        token: token?['token'],
        params: {
          'order_id': orderId.value,
          'status': 'confirmed',
        },
      );
      orderStausModel.value = UpdateOrderStatusModel.fromJson(response.data);
      if (orderStausModel.value?.status == true) {
        showSnackBar('Order accepted successfully');
        await getOrders();
        Get.back();
      }
    } catch (e) {
      handleControllerExceptions(e);
    }
  }

  Future<void> rejectOrder() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      final response = await APIHelper().request(
        url: 'seller/orders/status/update',
        method: Method.POST,
        token: token?['token'],
        params: {
          'order_id': orderId.value,
          'status': 'cancelled',
        },
      );
      orderStausModel.value = UpdateOrderStatusModel.fromJson(response.data);
      if (orderStausModel.value?.status == true) {
        showSnackBar('Order rejected');
        await getOrders();
        Get.back();
      }
    } catch (e) {
      handleControllerExceptions(e);
    }
  }
}
