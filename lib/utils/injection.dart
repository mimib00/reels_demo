import 'package:get_it/get_it.dart';
import 'package:reels_demo/features/reels/data/data_srource/api_datasource.dart';
import 'package:reels_demo/features/reels/data/repository/reel_repo_impl.dart';
import 'package:reels_demo/features/reels/domain/repository/reel_repo.dart';
import 'package:reels_demo/features/reels/domain/usecases/reel_usecases.dart';
import 'package:reels_demo/features/reels/presentation/cubit/reels_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory(() => ReelsCubit(locator<FetchReels>(), locator<FetchLocalReels>()));

  locator.registerLazySingleton(() => FetchReels(locator()));
  locator.registerLazySingleton(() => FetchLocalReels(locator()));

  locator.registerLazySingleton<ReelRepository>(() => ReelRepoImpl(locator()));

  locator.registerLazySingleton<ApiDataSource>(() => ApiDataSourceImpl());
}
