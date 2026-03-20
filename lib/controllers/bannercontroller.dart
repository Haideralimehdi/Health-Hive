import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBanners();
  }

  void loadBanners() {
    bannerImages.value = [
      'assets/images/1.jpeg',
      'assets/images/2.jpeg',
      'assets/images/3.jpeg',
      'assets/images/4.jpeg',
      'assets/images/5.jpeg',
    ];
  }
}
