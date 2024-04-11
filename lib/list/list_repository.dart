import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos/hash_extension.dart';

part 'list_repository.g.dart';

/// Local data source In-memory cache
@visibleForTesting
Map<String, TaskList> listDB = {};

/// TaskList model
@JsonSerializable()
class TaskList extends Equatable {
  ///Constructor
  const TaskList({required this.id, required this.name});

  /// Deserialisation
  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  ///list id field
  final String id;

  /// List name
  final String name;

  //// toJson
  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  ///Copy with method
  TaskList copyWith({
    String? id,
    String? name,
  }) {
    return TaskList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

///Repository class
class TaskListRepository {
  ///Check internal data source for a list with a given id
  Future<TaskList?> listById(String id) async {
    return listDB[id];
  }

  ///Get all list from data source
  Map<String, dynamic> getAllList() {
    final formattedList = <String, dynamic>{};
    if (listDB.isNotEmpty) {
      listDB.forEach(
        (String id) {
          final currentList = listDB[id];
          formattedList[id] = currentList?.toJson();
        } as void Function(String key, TaskList value),
      );
    }
    return formattedList;
  }

  ///Creating a mew list
  String createList({required String name}) {
    ///dynamically generate id
    final id = name.hashValue;

    ///create new task list object and pass two variable
    final list = TaskList(id: id, name: name);

    ///add new obj to data source
    listDB[id] = list;

    return id;
  }

  /// delete the task list obj with given id
  void deleteList({required String id}) {
    listDB.remove(id);
  }

  /// update list
  Future<void> updateList({required String id, required String name}) async {
    final currentList = listDB[id];
    if (currentList == null) {
      return Future.error(Exception('List not found'));
    }
    listDB[id] = TaskList(id: id, name: name);
  }
}
