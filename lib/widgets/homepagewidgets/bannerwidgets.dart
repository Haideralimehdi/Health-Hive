// ignore_for_file: file_names, unused_field, avoid_unnecessary_containers, prefer_const_constructors, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:e_comm/controllers/banners-controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/bannercontroller.dart';


class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

   final BannerController controller = Get.put(BannerController());
    final List<String> bannerImages = [
    'assets/images/1.jpeg',
    'assets/images/2.jpeg',
    'assets/images/3.jpeg',
    'assets/images/4.jpeg',
    'assets/images/5.jpeg',
  ];

  @override
Widget build(BuildContext context) {
  return Container(
    child: CarouselSlider(
      items: bannerImages
          .map(
            (imageUrl) => ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset( // using local asset
                imageUrl,
                fit: BoxFit.cover,
                width: Get.width - 10,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        autoPlay: true,
        aspectRatio: 2.5,
        viewportFraction: 1,
      ),
    ),
  );
}
}