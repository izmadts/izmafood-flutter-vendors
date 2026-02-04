import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/controllers/dash_board_controller.dart';
import 'package:izma_foods_vendor/pages/orders/orders_page.dart';
import 'package:izma_foods_vendor/pages/products/products_page.dart';

import '../config/theme.dart';
import 'home/home_page.dart';
import 'more/more_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final dashBoardController = Get.put(DashBoardController());
  RxList screens = RxList([
    HomePage(),
    ProductsPage(),
    OrdersPage(),
    MorePage(),
  ]);
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: screens[currentIndex.value],
        bottomNavigationBar: Container(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                offset: Offset(0, -1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.pinned,
            backgroundColor: Colors.white,
            snakeShape: SnakeShape.circle,
            unselectedItemColor: kcSecondaryColor,
            selectedItemColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            currentIndex: currentIndex.value,
            onTap: (index) => currentIndex.value = index,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined)),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined)),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined)),
              BottomNavigationBarItem(icon: Icon(Icons.menu_rounded))
            ],
          ),
        ),
      );
    });
  }
}
