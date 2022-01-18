import 'package:dio/dio.dart';
import 'package:sejun_purpledog/enums/purpledog_category_enum.dart';
import 'package:sejun_purpledog/extensions/extensions.dart';

class PurpledogRepository {
  static final PurpledogRepository _instance = PurpledogRepository._internal();

  factory PurpledogRepository() => _instance;

  PurpledogRepository._internal() {}

  final Dio _dio = Dio()
    ..options.baseUrl = 'https://hacker-news.firebaseio.com/v0'
    ..interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      print(response.data.toString());
      return handler.next(response);
    }));


  getItem(PurpledogCategory purpledogCategory) {
    return _dio.get('/${purpledogCategory.getCategoryString()}.json',
        queryParameters: {'print': 'pretty'});
  }

  getDetailItem(String id) {
    return _dio.get('/item/${id}.json', queryParameters: {'print': 'pretty'});
  }
}
