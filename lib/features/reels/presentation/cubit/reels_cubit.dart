import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';
import 'package:reels_demo/features/reels/domain/usecases/reel_usecases.dart';

part 'reels_state.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit(this.fetchReels, this.fetchLocalReels) : super(ReelsInitial()) {
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchLocalReels(page: 0);
      bool hasInternet = await InternetConnection().hasInternetAccess;
      if (hasInternet) {
        _fetchReels(page: pageKey);
      }
    });
  }

  final FetchReels fetchReels;
  final FetchLocalReels fetchLocalReels;

  final PagingController<int, ReelEntity> _pagingController = PagingController(
    firstPageKey: 1,
    invisibleItemsThreshold: 3,
  );

  PagingController<int, ReelEntity> get pagingController => _pagingController;
  bool hasLocal = false;

  Future<void> _fetchReels({int page = 1}) async {
    try {
      if (hasLocal) {
        _pagingController.value.itemList?.clear();
      }
      final res = await fetchReels.excute(page: page);

      res.fold(
        (e) => _pagingController.error = e.message,
        (data) async {
          final isLastPage = data.length < 10;
          if (isLastPage) {
            _pagingController.appendLastPage(data);
          } else {
            final nextPageKey = page + 1;
            _pagingController.appendPage(data, nextPageKey);
          }
        },
      );
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Error Occured");
      _pagingController.error = "Error Occured";
    }
  }

  Future<void> _fetchLocalReels({int page = 1}) async {
    try {
      final res = await fetchLocalReels.excute(page: page);

      res.fold(
        (e) => _pagingController.error = e.message,
        (data) async {
          _pagingController.refresh();
          final isLastPage = data.length < 5;
          if (isLastPage) {
            _pagingController.appendLastPage(data);
          } else {
            final nextPageKey = page + 1;
            _pagingController.appendPage(data, nextPageKey);
          }

          hasLocal = true;
        },
      );
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Error Occured");
      _pagingController.error = "Error Occured";
    }
  }
}
