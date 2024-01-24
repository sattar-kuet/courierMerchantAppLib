import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoIframe extends StatefulWidget {
  const VideoIframe({
    super.key,
    required this.videoUrl,
  });
  final String videoUrl;

  @override
  State<VideoIframe> createState() => _VideoIframeState();
}

class _VideoIframeState extends State<VideoIframe> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    _controller.setFullScreenListener(
      (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );
    _controller.loadVideoById(videoId: widget.videoUrl);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      builder: (context, player) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: player,
          ),
        );
      },
      controller: _controller,
    );
  }
}
