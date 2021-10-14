import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String name;
  @JsonKey(name: "create_date")
  final String createDate;
  @JsonKey(name: "is_done")
  final bool isDone;
  final int? pk;

  TaskModel(this.name, this.createDate, this.isDone, this.pk);

  static TaskModel fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
