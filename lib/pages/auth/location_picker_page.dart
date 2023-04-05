import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../config/theme.dart';
import '../widget/izma_primary_button.dart';
import '../widget/izma_text_field.dart';

class LocationPickerPage extends StatelessWidget {
  const LocationPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(30.196314610384327, 71.4475604205322),
                  zoom: 13.5,
                ),
              ),
              Positioned(
                top: kdPadding,
                left: kdPadding,
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: kcPrimaryColor,
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 26,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  // height: 350,
                  padding: EdgeInsets.only(bottom: 30, top: 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: kcPrimaryColor, borderRadius: BorderRadius.circular(kdBorderRadius)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: kcGreyColor,
                            borderRadius: BorderRadius.circular(kdBorderRadius),
                          ),
                        ),
                      ),
                      SizedBox(height: kdPadding),
                      IzmaTextField(prefixIcon: Icons.search, hintText: "Search for location"),
                      IzmaPrimaryButton(
                        title: "Save this location",
                        suffixIcon: Icons.save_outlined,
                        // onTap: () => Get.to(() => PhoneNumberPage()),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
