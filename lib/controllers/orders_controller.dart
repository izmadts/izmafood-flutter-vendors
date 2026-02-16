import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/live_order_tracking_model.dart'
    show Cancelled, LiveOrderTrackingModel;

class OrdersController extends GetxController {
  final selectedOrderStatus = 'Pending'.obs;
  final liveOrderTrackingModel = Rxn<LiveOrderTrackingModel>();
  final isLoading = false.obs;

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
}
