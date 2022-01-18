import 'package:intl/intl.dart';
import 'package:sejun_purpledog/entity/get_detail_item_response.dart';
import 'package:sejun_purpledog/enums/purpledog_category_enum.dart';

/**
 * Extension methods
 */

extension PurpledogCategoryExtension on PurpledogCategory {
  getCategoryString() {
    switch (this) {
      case PurpledogCategory.askstories:
        return 'askstories';
      case PurpledogCategory.jobstories:
        return 'jobstories';
      case PurpledogCategory.newstories:
        return 'newstories';
      case PurpledogCategory.showstories:
        return 'showstories';
      case PurpledogCategory.topstories:
        return 'topstories';
    }
  }
}

extension DateExtension on int?{
  convertUnixTimeToDate(String formatString) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this! * 1000);

    return DateFormat(formatString).format(dateTime);
  }
}

extension PrettyStringExtension on GetDetailItemResponse{
  toPrettyString(){
    return '''
    Title : $title
    Id : $id
    Time : ${time.convertUnixTimeToDate('yyyy/MM/dd HH:mm:ss')}
    By : $by
    Descendants : $descendants
    Kids : $kids
    Score : $score
    Type : $type
    Url : $url
    ''';
  }
}