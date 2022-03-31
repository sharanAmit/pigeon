// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 3;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.todo_id)
      ..writeByte(1)
      ..write(obj.user_id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.due_on)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      json['todo_id'] as int,
      json['user_id'] as int,
      json['title'] as String,
      DateTime.parse(json['due_on'] as String),
      json['status'] as String,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'todo_id': instance.todo_id,
      'user_id': instance.user_id,
      'title': instance.title,
      'due_on': instance.due_on.toIso8601String(),
      'status': instance.status,
    };
