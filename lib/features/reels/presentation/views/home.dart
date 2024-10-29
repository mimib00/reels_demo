import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';
import 'package:reels_demo/features/reels/presentation/cubit/reels_cubit.dart';
import 'package:reels_demo/features/reels/presentation/widgets/reel_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ReelsCubit>();
    return Scaffold(
      body: PagedPageView<int, ReelEntity>(
        pagingController: controller.pagingController,
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        onPageChanged: (index) {},
        builderDelegate: PagedChildBuilderDelegate<ReelEntity>(
          firstPageProgressIndicatorBuilder: (context) => Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
          itemBuilder: (context, item, index) {
            return ReelPlayer(
              reel: item,
            );
          },
        ),
      ),
    );
  }
}
