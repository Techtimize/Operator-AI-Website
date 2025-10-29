import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RobotAnimation extends StatefulWidget {
  final double width;
  final double height;
  final VoidCallback? onTap;

  const RobotAnimation({
    super.key,
    required this.width,
    required this.height,
    this.onTap,
  });

  @override
  RobotAnimationState createState() => RobotAnimationState();
}

class RobotAnimationState extends State<RobotAnimation>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _videoController;
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;

  static const int videoDurationMs = 2750;
  static const int walkDurationMs = 1375;
  static const double finalRight = 20;

  bool _isInitialized = false;
  bool _isAnimationStarted = false;
  bool _isDisposed = false;
  int _playAttempts = 0;
  static const int maxPlayAttempts = 5;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: walkDurationMs),
    );

    const double initialRight = -250;
    _positionAnimation = Tween<double>(begin: initialRight, end: finalRight)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        _initializeVideo();
      }
    });
  }

  Future<void> _initializeVideo() async {
    if (_isDisposed) return;

    await _videoController?.dispose();
    _videoController = VideoPlayerController.asset(
      'assets/animations/robot1.webm',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    try {
      await _videoController!.initialize();
      if (_isDisposed) return;
      await _videoController!.setLooping(false);
      await _videoController!.setVolume(0.0);
      await _videoController!.setPlaybackSpeed(1.0);
      await _videoController!.seekTo(Duration.zero);
      _videoController!.addListener(_monitorPlayback);

      if (mounted && !_isDisposed) {
        setState(() {
          _isInitialized = true;
        });
        _startAnimation();
      }
    } catch (_) {
      if (mounted && !_isDisposed && _playAttempts < maxPlayAttempts) {
        _playAttempts++;
        Future.delayed(const Duration(milliseconds: 500), _initializeVideo);
      }
    }
  }

  void _monitorPlayback() {
    if (_isDisposed || _videoController == null) return;
    if (_isAnimationStarted &&
        _isInitialized &&
        !_videoController!.value.isPlaying &&
        _videoController!.value.position.inMilliseconds < videoDurationMs &&
        _playAttempts < maxPlayAttempts) {
      _playAttempts++;
      _videoController!.seekTo(Duration.zero).then((_) {
        if (!_isDisposed && _videoController != null) {
          _videoController!.play();
          if (!_animationController.isAnimating &&
              _animationController.value < 1.0) {
            _animationController.forward();
          }
        }
      });
    }
  }

  void _startAnimation() {
    if (_isDisposed || _isAnimationStarted) return;
    if (_isInitialized && _videoController != null && mounted) {
      _isAnimationStarted = true;
      _videoController!.seekTo(Duration.zero).then((_) {
        if (_isDisposed) return;
        _videoController!.play();
        _animationController.forward();
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_isDisposed || _videoController == null) return;
          if (!_videoController!.value.isPlaying &&
              _playAttempts < maxPlayAttempts) {
            _playAttempts++;
            _videoController!.play();
          }
        });
      });
    } else if (!_isDisposed && _playAttempts < maxPlayAttempts) {
      _playAttempts++;
      Future.delayed(const Duration(milliseconds: 200), _startAnimation);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController.dispose();
    if (_videoController != null) {
      _videoController!.removeListener(_monitorPlayback);
      _videoController!.dispose();
      _videoController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double bottomMargin;
    if (width < 600) {
      bottomMargin = 5;
    } else if (width < 900) {
      bottomMargin = 8;
    } else if (width < 1200) {
      bottomMargin = 10;
    } else if (width < 1600) {
      bottomMargin = 15;
    } else {
      bottomMargin = 20;
    }

    return AnimatedBuilder(
      animation: _positionAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              bottom: bottomMargin,
              right: _positionAnimation.value,
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: _isInitialized && _videoController != null
                    ? Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                          Positioned.fill(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: widget.onTap,
                            ),
                          ),
                        ],
                      )
                    : Container(color: Colors.transparent),
              ),
            ),
          ],
        );
      },
    );
  }
}
