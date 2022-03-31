import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Post {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int user_id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String body;
  Post(
    this.id,
    this.user_id,
    this.title,
    this.body,
  );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
