import 'package:flutter/material.dart';
import 'package:get/get.dart';

void navigateTo(BuildContext context, Widget page) {
  Get.to(() => page);
}

void navigateOff(BuildContext context, Widget page) {
  Get.off(() => page);
}

void navigateAndRemoveUntil(BuildContext context, Widget page) {
  Get.offAll(() => page);
}
void navigateBack(BuildContext context) {
  Get.back();
}
