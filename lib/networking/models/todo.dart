import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Todo {
  @HiveField(0)
  final int todo_id;
  @HiveField(1)
  final int user_id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final DateTime due_on;
  @HiveField(4)
  final String status;
  Todo(
    this.todo_id,
    this.user_id,
    this.title,
    this.due_on,
    this.status,
  );

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
