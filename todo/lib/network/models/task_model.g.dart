// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return TaskModel(
    json['name'] as String,
    json['create_date'] as String,
    json['is_done'] as bool,
    json['pk'] as int?,
  );
}

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'name': instance.name,
      'create_date': instance.createDate,
      'is_done': instance.isDone,
      'pk': instance.pk,
    };
