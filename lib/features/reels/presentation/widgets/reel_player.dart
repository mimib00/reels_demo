import 'dart:isolate';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';
import 'package:reels_demo/features/reels/domain/entities/reel.dart';
import 'package:reels_demo/utils/constants.dart';
import 'package:video_player/video_player.dart';

class ReelPlayer extends StatefulWidget {
  const ReelPlayer({
    super.key,
    required this.reel,
  });

  final ReelEntity reel;

  @override
  State<ReelPlayer> createState() => _ReelPlayerState();
}

class _ReelPlayerState extends State<ReelPlayer> {
  VideoPlayerController? _controller;

  ValueNotifier<bool> isCollapsed = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final cached = await DefaultCacheManager().getFileFromCache(widget.reel.reelUrl);

    if (cached != null) {
      _controller = VideoPlayerController.file(cached.file)
        ..initialize().then((_) async {
          await _controller?.setLooping(true);
          await _controller?.setVolume(0.85);
          await _controller?.play();
          setState(() {});
        });
    } else {
      Isolate.run(
        () async {
          await DefaultCacheManager().downloadFile(widget.reel.reelUrl, key: widget.reel.reelUrl);
        },
      );
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.reel.reelUrl))
        ..initialize().then((_) async {
          await _controller?.setLooping(true);
          await _controller?.setVolume(0.85);
          await _controller?.play();
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          _controller == null
              ? Container()
              : Visibility(
                  visible: _controller!.value.isInitialized,
                  replacement: Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.reel.thumbnailUrl,
                    ),
                  ),
                  child: Positioned(
                    height: kHeight(context),
                    width: kWidth(context),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            if (_controller!.value.isPlaying) {
                              _controller?.pause();
                            } else {
                              _controller?.play();
                            }
                          },
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                    ),
                  ),
                ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Gap(10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.visibility_rounded),
                    title: Text("${widget.reel.totalViews} Views"),
                    trailing: IconButton(
                      onPressed: () {
                        if ((_controller?.value.volume ?? 0.85) > 0) {
                          _controller?.setVolume(0);
                        } else {
                          _controller?.setVolume(.85);
                        }
                        setState(() {});
                      },
                      icon: (_controller?.value.volume ?? 0.85) > 0 ? const Icon(Icons.volume_up_rounded) : const Icon(Icons.volume_mute_rounded),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: widget.reel.user.pictureUrl == null
                                  ? const CircleAvatar(
                                      child: Icon(Icons.person_rounded),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(360),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.reel.user.pictureUrl!,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              minVerticalPadding: 0,
                              title: Text(widget.reel.user.name),
                              subtitle: Text("@${widget.reel.user.username}"),
                              trailing: FilledButton(onPressed: () {}, child: widget.reel.isFollowed ? const Text("Followed") : const Text("Follow")),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.loose(Size(double.infinity, kHeight(context) * .25)),
                              child: SingleChildScrollView(
                                child: ReadMoreText(
                                  widget.reel.title,
                                  isCollapsed: isCollapsed,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  annotations: [
                                    Annotation(
                                      regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
                                      spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
                                        text: text,
                                        style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: widget.reel.isLiked ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                              ),
                              Text(widget.reel.totalLikes.toString()),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.comment_rounded),
                              ),
                              Text(widget.reel.totalComments.toString()),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.share),
                              ),
                              Text(widget.reel.totalShares.toString()),
                            ],
                          ),
                          const Gap(50),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
