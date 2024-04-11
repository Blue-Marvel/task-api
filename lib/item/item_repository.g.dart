// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      listId: json['listId'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'listId': instance.listId,
      'description': instance.description,
      'status': instance.status,
    };
