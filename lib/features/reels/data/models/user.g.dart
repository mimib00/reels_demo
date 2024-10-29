// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['user_id'] as num).toInt(),
      json['fullname'] as String,
      json['username'] as String,
      json['designation'] as String?,
      json['profile_picture_cdn'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.id,
      'fullname': instance.name,
      'username': instance.username,
      'designation': instance.designation,
      'profile_picture_cdn': instance.pictureUrl,
    };
