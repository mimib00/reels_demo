import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reels_demo/features/reels/domain/entities/user.dart';

part "user.g.dart";

@JsonSerializable()
class User extends Equatable {
  const User(
    this.id,
    this.name,
    this.username,
    this.designation,
    this.pictureUrl,
  );

  @JsonKey(name: "user_id")
  final int id;
  @JsonKey(name: "fullname")
  final String name;
  final String username;
  final String? designation;
  @JsonKey(name: "profile_picture_cdn")
  final String? pictureUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        designation,
        pictureUrl,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        username: username,
        designation: designation,
        pictureUrl: pictureUrl,
      );
}

class UserConverter extends TypeConverter<User, String> {
  @override
  User decode(String databaseValue) {
    final json = jsonDecode(databaseValue);
    return User.fromJson(json);
  }

  @override
  String encode(User value) {
    return json.encode(value.toJson());
  }
}
