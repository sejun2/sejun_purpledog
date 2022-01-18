import 'package:json_annotation/json_annotation.dart';

part 'get_detail_item_response.g.dart';

@JsonSerializable()
class GetDetailItemResponse {
  String? by;
  int? descendants;
  int? id;
  List<int>? kids;
  int? score;
  int? time;
  String? title;
  String? type;
  String? url;

  GetDetailItemResponse(
      {this.by,
      this.descendants,
      this.id,
      this.kids,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url});

  factory GetDetailItemResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDetailItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDetailItemResponseToJson(this);
}
