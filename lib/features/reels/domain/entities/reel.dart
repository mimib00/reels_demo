import 'package:equatable/equatable.dart';
import 'package:reels_demo/features/reels/domain/entities/user.dart';

class ReelEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String reelUrl;
  final String thumbnailUrl;
  final int totalViews;
  final int totalLikes;
  final int totalComments;
  final int totalShares;
  final int totalWishes;
  final String aspectRatio;
  final bool isLiked;
  final bool isWished;
  final bool isFollowed;
  final String? language;
  final UserEntity user;

  const ReelEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.reelUrl,
    required this.thumbnailUrl,
    required this.totalViews,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.totalWishes,
    required this.aspectRatio,
    required this.isLiked,
    required this.isWished,
    required this.isFollowed,
    required this.language,
    required this.user,
  });

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
        totalShares,
        totalWishes,
        aspectRatio,
        isLiked,
        isWished,
        isFollowed,
        language,
        user,
      ];
}
