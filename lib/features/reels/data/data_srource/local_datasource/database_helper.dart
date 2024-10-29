import 'dart:async';

import 'package:floor/floor.dart';
import 'package:reels_demo/features/reels/data/models/reel.dart';
import 'package:reels_demo/features/reels/data/models/user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database_helper.g.dart';

@Database(version: 1, entities: [Reel])
abstract class AppDatabase extends FloorDatabase {
  ReelDao get reelDao;
}

class DatabaseHelper {
  DatabaseHelper._init();

  static final DatabaseHelper instance = DatabaseHelper._init();

  late final AppDatabase db;
  late final ReelDao reelDao;

  Future<void> initializeDatabase() async {
    db = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    reelDao = db.reelDao;
  }

  Future<List<Reel>> fetchAllReels({int page = 1}) async {
    return await reelDao.findAllReels(page);
  }

  Future<void> insertReel(Reel reel) async {
    await reelDao.insertReel(reel);
  }
}
