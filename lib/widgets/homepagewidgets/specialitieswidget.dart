// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../model/specialitiesmodel.dart';

class specialitieswidget extends StatefulWidget {
  const specialitieswidget({super.key});

  @override
  State<specialitieswidget> createState() => _specialitieswidgetState();
}

class _specialitieswidgetState extends State<specialitieswidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("specialities").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No specialities found:"),
          );
        }
        if (snapshot.data != null) {
          return Container(
            height: Get.height / 6,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {

                SpecialitiesModel specialitiesModel = SpecialitiesModel(
                  specialityId: snapshot.data!.docs[index]['specialityId'],
                  specialityImg: snapshot.data!.docs[index]['specialityImg'],
                  specialityName: snapshot.data!.docs[index]['specialityName'],
                );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsetsDirectional.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 12,
                            imageProvider: CachedNetworkImageProvider(
                              specialitiesModel.specialityImg,
                            ),
                            // tags: [_tag('Category', () {}), _tag('Product', () {})],
                            title: Center(
                              child: Text(
                                specialitiesModel.specialityName,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        }
        return Container();
      },
    );
    
  }
}
