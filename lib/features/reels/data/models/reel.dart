import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reels_demo/features/reels/data/models/user.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';

part 'reel.g.dart';

@JsonSerializable()
@entity
class Reel extends Equatable {
  const Reel(
    this.id,
    this.title,
    this.description,
    this.reelUrl,
    this.thumbnailUrl,
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.totalShare,
    this.totalWishes,
    this.aspectRatio,
    this.isLiked,
    this.isWished,
    this.isFollowed,
    this.language,
    this.user,
  );

  @PrimaryKey(autoGenerate: false)
  final int id;
  final String title;
  final String? description;
  @JsonKey(name: "cdn_url")
  final String reelUrl;
  @JsonKey(name: "thumb_cdn_url")
  final String thumbnailUrl;
  @JsonKey(name: "total_views")
  final int totalViews;
  @JsonKey(name: "total_likes")
  final int totalLikes;
  @JsonKey(name: "total_comments")
  final int totalComments;
  @JsonKey(name: "total_share")
  final int totalShare;
  @JsonKey(name: "total_wishlist")
  final int totalWishes;
  @JsonKey(name: "video_aspect_ratio")
  final String aspectRatio;
  @JsonKey(name: "is_liked")
  final bool isLiked;
  @JsonKey(name: "is_wished")
  final bool isWished;
  @JsonKey(name: "is_follow")
  final bool isFollowed;
  final String? language;
  @TypeConverters([UserConverter])
  final User user;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        reelUrl,
        thumbnailUrl,
        totalViews,
        totalLikes,
        totalComments,
        totalShare,
        totalWishes,
        aspectRatio,
        isLiked,
        isWished,
        isFollowed,
        language,
        user,
      ];

  factory Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelToJson(this);

  ReelEntity toEntity() => ReelEntity(
        id: id,
        title: title,
        description: description,
        reelUrl: reelUrl,
        thumbnailUrl: thumbnailUrl,
        totalViews: totalViews,
        totalLikes: totalLikes,
        totalComments: totalComments,
        totalShares: totalShare,
        totalWishes: totalWishes,
        aspectRatio: aspectRatio,
        isLiked: isLiked,
        isWished: isWished,
        isFollowed: isFollowed,
        language: language,
        user: user.toEntity(),
      );
}

@dao
abstract class ReelDao {
  @Query('SELECT * FROM Reel LIMIT 5 OFFSET :page')
  Future<List<Reel>> findAllReels(int page);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertReel(Reel reel);
}
