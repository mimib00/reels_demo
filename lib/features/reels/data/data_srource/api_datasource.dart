import 'dart:convert';

import 'package:reels_demo/features/reels/data/data_srource/local_datasource/database_helper.dart';
import 'package:reels_demo/features/reels/data/models/reel.dart';
import 'package:reels_demo/utils/constants.dart';

import 'package:http/http.dart' as http;

abstract class ApiDataSource {
  Future<List<Reel>> fetchReels({int page = 1});
  Future<List<Reel>> fetchLocalReels({int page = 1});
}

class ApiDataSourceImpl implements ApiDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Future<List<Reel>> fetchReels({int page = 1}) async {
    final uri = Uri.parse("$baseUrl/bytes/all?page=$page&limit=10&country=United+States");
    final res = await http.get(uri);
    final data = jsonDecode(res.body)["data"]["data"] as List<dynamic>;
    final List<Reel> reels = [];
    for (final item in data) {
      final reel = Reel.fromJson(item);
      reels.add(reel);
      await _databaseHelper.insertReel(reel);
    }

    return reels;
  }

  @override
  Future<List<Reel>> fetchLocalReels({int page = 1}) async {
    return await _databaseHelper.fetchAllReels(page: page);
  }
}
