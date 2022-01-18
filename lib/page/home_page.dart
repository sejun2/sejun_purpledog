import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sejun_purpledog/controllers/home_controller.dart';
import 'package:sejun_purpledog/entity/get_detail_item_response.dart';
import 'package:sejun_purpledog/enums/purpledog_category_enum.dart';
import 'package:sejun_purpledog/extensions/extensions.dart';
import 'package:sejun_purpledog/page/detail_page.dart';

class HomePage extends GetView<HomeController> {
  final DEFAULT_THROTTLE_TIME = 800; //ms

  HomePage({Key? key}) : super(key: key);

  bool throttleMutex = false; //throttle mutex for requestItem
  bool detailThrottleMutex = false; //throttle mutex for requestDetailItem

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            buildProgressIndicator(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    buildRequestButton(PurpledogCategory.newstories),
                    buildRequestButton(PurpledogCategory.askstories),
                    buildRequestButton(PurpledogCategory.jobstories),
                    buildRequestButton(PurpledogCategory.showstories),
                    buildRequestButton(PurpledogCategory.topstories),
                  ],
                ),
                Obx(
                  () => Expanded(
                      child: ListView.separated(
                          itemBuilder: (ctx, index) {
                            return buildListItem(index);
                          },
                          separatorBuilder: (ctx, index) {
                            return buildSeparator();
                          },
                          itemCount:
                              (controller.getItemResponse as List<dynamic>?)
                                      ?.length ??
                                  0)),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Container buildSeparator() {
    return Container(
      height: 1,
      color: Colors.grey,
    );
  }

  TextButton buildRequestButton(PurpledogCategory purpledogCategory) {
    return TextButton(
        onPressed: () {
          if (throttleMutex == true) {
            return;
          }
          throttleMutex = true;
          Timer(Duration(milliseconds: DEFAULT_THROTTLE_TIME), () {
            throttleMutex = false;
          });
          controller.getItem(purpledogCategory);
        },
        child: Text(purpledogCategory.getCategoryString()));
  }

  Obx buildProgressIndicator() {
    return Obx(() {
      return controller.isProcess
          ? const Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()))
          : const SizedBox();
    });
  }

  InkWell buildListItem(int index) {
    return InkWell(
      onTap: () async {
        if (detailThrottleMutex) {
          return;
        }
        detailThrottleMutex = true;

        //set detailThrottleMutex false by DEFAULT_THROTTLE_TIME
        Timer(Duration(milliseconds: DEFAULT_THROTTLE_TIME), () {
          detailThrottleMutex = false;
        });

        var item =
            (controller.getItemResponse as List<dynamic>?)![index]?.toString();

        await controller.getDetailItem(item!);

        await Get.to(() => DetailPage(),
            arguments:
                controller.getDetailItemResponse as GetDetailItemResponse);
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        child: Text(
            (controller.getItemResponse as List<dynamic>?)![index].toString()),
      ),
    );
  }
}
