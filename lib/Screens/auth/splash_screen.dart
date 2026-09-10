import 'dart:async';

import 'package:flutter/material.dart';

/// Opening splash screen based on the supplied Figma frame.
///
/// Set [isAuthenticated] from your stored user/session state. After [duration],
/// authenticated users go to Home; everyone else goes to Login.
class ServiceWalaSplashScreen extends StatefulWidget {
  const ServiceWalaSplashScreen({
    super.key,
    required this.isAuthenticated,
    this.duration = const Duration(seconds: 3),
    this.logoAsset,
    this.onNavigateToLogin,
    this.onNavigateToHome,
  });

  final bool isAuthenticated;
  final Duration duration;

  // FIGMA PLACEHOLDER: replace with your exported Figma logo widget, e.g.
  // Image.asset('assets/service_wala_logo.png', width: 49, height: 49).
  final Widget? logoAsset;

  final VoidCallback? onNavigateToLogin;
  final VoidCallback? onNavigateToHome;

  @override
  State<ServiceWalaSplashScreen> createState() => _ServiceWalaSplashScreenState();
}

class _ServiceWalaSplashScreenState extends State<ServiceWalaSplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _navigationTimer;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
    _navigationTimer = Timer(widget.duration, _continueIntoApp);
  }

  void _continueIntoApp() {
    if (!mounted) return;
    if (widget.isAuthenticated) {
      widget.onNavigateToHome?.call();
    } else {
      widget.onNavigateToLogin?.call();
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF001449), Color(0xFF0033B6), Color(0xFF0046EE)],
              stops: [0, .5, 1],
            ),
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOut,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, -32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _logo(),
                          const SizedBox(height: 17),
                          const Text(
                            'ServiceWala',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -.45,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'YOUR SERVICE PARTNER',
                            style: TextStyle(
                              color: Color(0xFFC9DCFF),
                              fontSize: 6.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: _PageDots(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _logo() => Container(
        width: 49,
        height: 49,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Color(0x24000000), blurRadius: 9, offset: Offset(0, 4)),
          ],
        ),
        child: widget.logoAsset ??
            const Icon(Icons.home_work_outlined, color: Color(0xFF0B4DFF), size: 26),
      );
}

class _PageDots extends StatelessWidget {
  const _PageDots();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: index == 0 ? const Color(0xFF44E8FF) : const Color(0xFF77A7FF),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
}
