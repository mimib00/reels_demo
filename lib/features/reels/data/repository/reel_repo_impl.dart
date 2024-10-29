import 'package:dartz/dartz.dart';
import 'package:reels_demo/features/reels/data/data_srource/api_datasource.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';
import 'package:reels_demo/features/reels/domain/errors/errors.dart';
import 'package:reels_demo/features/reels/domain/exceptions/exceptions.dart';
import 'package:reels_demo/features/reels/domain/repository/reel_repo.dart';

class ReelRepoImpl implements ReelRepository {
  ReelRepoImpl(this.apiDataSource);

  final ApiDataSource apiDataSource;

  @override
  Future<Either<Errors, List<ReelEntity>>> fetchReels({int page = 1}) async {
    try {
      final reels = await apiDataSource.fetchReels(page: page);
      return Right(reels.map((reel) => reel.toEntity()).toList());
    } on ApiException catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, List<ReelEntity>>> fetchReelsLocal({int page = 1}) async {
    try {
      final reels = await apiDataSource.fetchLocalReels(page: page);
      return Right(reels.map((reel) => reel.toEntity()).toList());
    } on ApiException catch (e) {
      return Left(ApiError(e.toString()));
    }
  }
}
