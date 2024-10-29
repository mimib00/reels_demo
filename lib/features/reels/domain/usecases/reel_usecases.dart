import 'package:dartz/dartz.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';
import 'package:reels_demo/features/reels/domain/errors/errors.dart';
import 'package:reels_demo/features/reels/domain/repository/reel_repo.dart';

class FetchReels {
  FetchReels(this.repository);

  final ReelRepository repository;

  Future<Either<Errors, List<ReelEntity>>> excute({int page = 1}) => repository.fetchReels(page: page);
}

class FetchLocalReels {
  FetchLocalReels(this.repository);

  final ReelRepository repository;

  Future<Either<Errors, List<ReelEntity>>> excute({int page = 1}) => repository.fetchReelsLocal(page: page);
}
