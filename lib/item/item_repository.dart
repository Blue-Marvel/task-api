import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos/hash_extension.dart';

part 'item_repository.g.dart';

/// Local data source In-memory cache
@visibleForTesting
Map<String, TaskItem> itemDB = {};

/// TaskList model
@JsonSerializable()
class TaskItem extends Equatable {
  ///Constructor
  const TaskItem({
    required this.id,
    required this.name,
    required this.description,
    required this.listId,
    required this.status,
  });

  /// Deserialisation
  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  ///list id field
  final String id;

  /// List name
  final String name;

  ///itemm id
  final String listId;

  /// itemdescription
  final String description;

  ///item status
  final bool status;
  //// toJson
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  ///Copy with method
  TaskItem copyWith({
    String? id,
    String? name,
    String? listId,
    String? description,
    bool? status,
  }) {
    return TaskItem(
      id: id ?? this.id,
      name: name ?? this.name,
      listId: listId ?? this.listId,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

///Repository class
class TaskItemRepository {
  ///Check internal data source for a list with a given id
  Future<TaskItem?> itemById(String id) async {
    return itemDB[id];
  }

  ///Get all list from data source
  Map<String, dynamic> getAllItem() {
    final formattedList = <String, dynamic>{};
    if (itemDB.isNotEmpty) {
      itemDB.forEach(
        (String id) {
          final currentList = itemDB[id];
          formattedList[id] = currentList?.toJson();
        } as void Function(String key, TaskItem value),
      );
    }
    return formattedList;
  }

  ///Creating a mew list
  String createItem({
    required String name,
    required String listId,
    required String description,
    required bool status,
  }) {
    ///dynamically generate id
    final id = name.hashValue;

    ///create new task list object and pass two variable
    final item = TaskItem(
      id: id,
      name: name,
      listId: listId,
      description: description,
      status: status,
    );

    ///add new obj to data source
    itemDB[id] = item;

    return id;
  }

  /// delete the task list obj with given id
  void deleteItem({required String id}) {
    itemDB.remove(id);
  }

  /// update list
  Future<void> updateItem({
    required String id,
    required String name,
    required String listId,
    required String description,
    required bool status,
  }) async {
    final currentItem = itemDB[id];
    if (currentItem == null) {
      return Future.error(Exception('List not found'));
    }
    itemDB[id] = TaskItem(
      id: id,
      name: name,
      listId: listId,
      description: description,
      status: status,
    );
  }
}
