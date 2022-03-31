import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Comments {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int post_id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String body;
  Comments(
    this.id,
    this.post_id,
    this.name,
    this.email,
    this.body,
  );

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
