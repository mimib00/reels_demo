import 'package:dartz/dartz.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';
import 'package:reels_demo/features/reels/domain/errors/errors.dart';

abstract class ReelRepository {
  Future<Either<Errors, List<ReelEntity>>> fetchReels({int page = 1});
  Future<Either<Errors, List<ReelEntity>>> fetchReelsLocal({int page = 1});
}
