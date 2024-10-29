// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reel _$ReelFromJson(Map<String, dynamic> json) => Reel(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['description'] as String?,
      json['cdn_url'] as String,
      json['thumb_cdn_url'] as String,
      (json['total_views'] as num).toInt(),
      (json['total_likes'] as num).toInt(),
      (json['total_comments'] as num).toInt(),
      (json['total_share'] as num).toInt(),
      (json['total_wishlist'] as num).toInt(),
      json['video_aspect_ratio'] as String,
      json['is_liked'] as bool,
      json['is_wished'] as bool,
      json['is_follow'] as bool,
      json['language'] as String?,
      User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReelToJson(Reel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cdn_url': instance.reelUrl,
      'thumb_cdn_url': instance.thumbnailUrl,
      'total_views': instance.totalViews,
      'total_likes': instance.totalLikes,
      'total_comments': instance.totalComments,
      'total_share': instance.totalShare,
      'total_wishlist': instance.totalWishes,
      'video_aspect_ratio': instance.aspectRatio,
      'is_liked': instance.isLiked,
      'is_wished': instance.isWished,
      'is_follow': instance.isFollowed,
      'language': instance.language,
      'user': instance.user,
    };
