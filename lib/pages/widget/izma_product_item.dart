import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme.dart';

class IzmaProductItem extends StatelessWidget {
  const IzmaProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 0,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kdBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/temp/carrots.png',
                height: 130,
              ),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                child: Text(
                  "7 Up Single 1.5",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Rs 1000",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    "Rs 700",
                    style: TextStyle(
                      color: kcSecondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  // onPressed: () => Get.to(() => IzmaProductDetailsPage()),
                  onPressed: () {},

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => kcSecondaryColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text("Add to Bag", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                shape: BoxShape.circle,
              ),
              child: Text(
                "20% OFF",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
