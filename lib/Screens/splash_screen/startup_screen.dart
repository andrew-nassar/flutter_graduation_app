import 'dart:async';
import 'package:flutter/material.dart';

class LexApp extends StatefulWidget {
  const LexApp({super.key});

  @override
  State<LexApp> createState() => _LexAppState();
}

class _LexAppState extends State<LexApp> with TickerProviderStateMixin {
  bool loading = true;
  late AnimationController _iconController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    // Fake loading (3 seconds)
    Timer(const Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });

    // Main Icon animation (scale + rotate)
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    // Fade-in elements
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _iconController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F172A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // 🖼 Background Image
            Opacity(
              opacity: 0.2,
              child: Image.network(
                'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=800&q=80',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            // 🟠 Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xCC0F172A),
                    Color(0xFF0F172A)
                  ],
                ),
              ),
            ),

            // 🌟 Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top icons
                  FadeTransition(
                    opacity: _fadeController,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.shield_outlined,
                            color: Color(0x4DFFB703), size: 28),
                        SizedBox(width: 16),
                        Icon(Icons.workspace_premium_outlined,
                            color: Color(0x4DFFB703), size: 28),
                      ],
                    ),
                  ),

                  // Center logo and title
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: CurvedAnimation(
                                parent: _iconController,
                                curve: Curves.elasticOut),
                            child: RotationTransition(
                              turns: Tween<double>(begin: -0.5, end: 0)
                                  .animate(_iconController),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Glow
                                  Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: const Color(0x33FFB703),
                                      borderRadius: BorderRadius.circular(100),
                                      // blurRadius: 60,
                                    ),
                                  ),
                                  // Icon background
                                  Container(
                                    padding: const EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFFB703),
                                          Color(0xFFFFA000)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 16,
                                        )
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.scale_outlined,
                                      size: 80,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _fadeController,
                            child: Column(
                              children: [
                                const Text(
                                  'LEX',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 2,
                                  width: 96,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFFFFB703),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Your Trusted Legal Partner',
                                  style: TextStyle(
                                    color: Color(0xFFCBD5E1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom loading and footer
                  FadeTransition(
                    opacity: _fadeController,
                    child: Column(
                      children: [
                        if (loading) ...[
                          Stack(
                            children: [
                              Container(
                                height: 4,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut,
                                margin: const EdgeInsets.only(left: 0),
                                height: 4,
                                width: 100,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Color(0xFFFFB703),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Loading...',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                        const SizedBox(height: 24),
                        const Text(
                          'Excellence in Legal Services',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Decorative corners
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0x0DFFB703),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(120)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0x0DFFB703),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(120)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
