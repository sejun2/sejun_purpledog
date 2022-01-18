import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:sejun_purpledog/entity/get_detail_item_response.dart';
import 'package:sejun_purpledog/entity/get_item_response.dart';
import 'package:sejun_purpledog/enums/purpledog_category_enum.dart';
import 'package:sejun_purpledog/repository/purpledog_repository.dart';

class HomeController extends GetxController {
  late PurpledogRepository _purpledogRepository;

  final _isProcess = false.obs;

  get isProcess => _isProcess.value;

  final _getItemResponse = GetItemResponse().item.obs;

  get getItemResponse => _getItemResponse.value;

  final _getDetailItemResponse = GetDetailItemResponse().obs;

  get getDetailItemResponse => _getDetailItemResponse.value;

  late SortStrategy _sortStrategy;

  getItem(PurpledogCategory purpledogCategory) async {
    try {
      _isProcess.value = true;

      dio.Response response =
          await _purpledogRepository.getItem(purpledogCategory);

      processItem(response.data as List);
      _getItemResponse.value = response.data;
    } on Exception catch (e) {
      print(e);
    } finally {
      _isProcess.value = false;
    }
  }

   getDetailItem(String id) async {
    try {
      _isProcess.value = true;

      dio.Response response = await _purpledogRepository.getDetailItem(id);

      _getDetailItemResponse.value =
          GetDetailItemResponse.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
    } finally {
      _isProcess.value = false;
    }
  }

  processItem(List<dynamic> list) {
    return _sortStrategy.sort(list);
  }

  @override
  void onInit() {
    _purpledogRepository = PurpledogRepository();
    _sortStrategy = DescendSortStrategy();
    super.onInit();
  }
}

///SortStrategy interface
class SortStrategy {
  sort(List<dynamic> list) {}
}

///오름차순
class AscendSortStrategy implements SortStrategy {
  @override
  sort(List<dynamic> list) {
    list.sort((a, b) {
      return (a as int).compareTo(b);
    });
  }
}

///내림차순
class DescendSortStrategy implements SortStrategy {
  @override
  sort(List<dynamic> list) {
    list.sort((a, b) {
      return (b as int).compareTo(a);
    });
  }
}
