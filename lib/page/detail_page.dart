import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sejun_purpledog/entity/get_detail_item_response.dart';
import 'package:sejun_purpledog/extensions/extensions.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final GetDetailItemResponse _getDetailItemResponse;

  void initResources() {
    _getDetailItemResponse = Get.arguments as GetDetailItemResponse;
  }

  @override
  void initState() {
    initResources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${_getDetailItemResponse.toPrettyString()}'),
            ],
          ),
        ),
      ),
    );
  }
}
