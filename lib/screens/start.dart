import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'home.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _contentController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // Video Initialization
    _controller = VideoPlayerController.asset('assets/start.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0.0);
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });

    // Content Animation Initialization
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );

    _contentController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Full Screen Video Background
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Container(color: Colors.black),

          Container(color: Colors.black.withOpacity(0.15)),

          // Animated Top Bar


          // Animated Bottom Content
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Explore our\nbest coffees and teas',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lobster(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            offset: const Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildAnimatedButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secondAnim) => const HomeScreen(),
            transitionsBuilder: (context, anim, secondAnim, child) {
              return FadeTransition(opacity: anim, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween<double>(begin: 1.0, end: 1.05),
        curve: Curves.easeInOut,
        builder: (context, double scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF3A1F1A),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            'Get Started',
            style: GoogleFonts.pacifico(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
