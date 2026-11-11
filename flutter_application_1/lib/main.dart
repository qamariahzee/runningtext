import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const _sage = Color(0xFFA3B18A);
const _teal = Color(0xFF52796F);
const _ivory = Color(0xFFF7F6F0);
const _terracotta = Color(0xFFD49A72);
const _charcoal = Color(0xFF34423A);
const _muted = Color(0xFF7D857D);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction to Computer Science',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _ivory,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _teal,
          primary: _teal,
          secondary: _sage,
          surface: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: _charcoal),
          bodyMedium: TextStyle(color: _muted),
          titleMedium: TextStyle(color: _charcoal),
        ),
      ),
      home: const AcademicIntroductionPage(),
    );
  }
}

class AcademicIntroductionPage extends StatelessWidget {
  const AcademicIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  StudentHeader(),
                  SizedBox(height: 52),
                  AssignmentTitle(),
                  SizedBox(height: 34),
                  TypewriterGreeting(),
                  SizedBox(height: 42),
                  ChasingMarquee(),
                  SizedBox(height: 26),
                  _FooterNote(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentHeader extends StatelessWidget {
  const StudentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _sage.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _sage.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.auto_stories_rounded, color: _teal),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              '260605110231 - Azizah Nur Qamariah',
              style: TextStyle(
                color: _teal,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.15,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.circle, size: 8, color: _terracotta),
        ],
      ),
    );
  }
}

class AssignmentTitle extends StatelessWidget {
  const AssignmentTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 2,
              decoration: BoxDecoration(
                color: _terracotta,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'INFORMATICS ENGINEERING',
              style: TextStyle(
                color: _muted,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Tugas mata kuliah Introduction to Computer Science',
          style: TextStyle(
            color: _charcoal,
            fontSize: 32,
            height: 1.2,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: 52,
          height: 4,
          decoration: BoxDecoration(
            color: _sage,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

class TypewriterGreeting extends StatefulWidget {
  const TypewriterGreeting({super.key});

  @override
  State<TypewriterGreeting> createState() => _TypewriterGreetingState();
}

class _TypewriterGreetingState extends State<TypewriterGreeting>
    with SingleTickerProviderStateMixin {
  static const _greeting = 'Hello Mahasiswa UIN Maliki Malang';

  late final AnimationController _cursorController;
  Timer? _typingTimer;
  Timer? _restartTimer;
  int _visibleCharacters = 0;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 560),
    )..repeat(reverse: true);
    _startTyping();
  }

  void _startTyping() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 78), (timer) {
      if (!mounted) return;
      setState(() => _visibleCharacters++);
      if (_visibleCharacters == _greeting.length) {
        timer.cancel();
        _restartTimer = Timer(const Duration(milliseconds: 1700), () {
          if (!mounted) return;
          setState(() => _visibleCharacters = 0);
          _startTyping();
        });
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _restartTimer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.waving_hand_rounded, color: _terracotta, size: 21),
        const SizedBox(width: 11),
        Flexible(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _greeting.substring(0, _visibleCharacters),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: _teal,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              FadeTransition(
                opacity: _cursorController,
                child: Container(
                  width: 2,
                  height: 22,
                  margin: const EdgeInsets.only(left: 3),
                  color: _sage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChasingMarquee extends StatelessWidget {
  const ChasingMarquee({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 19, 18, 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _sage.withValues(alpha: 0.32)),
        boxShadow: [
          BoxShadow(
            color: _charcoal.withValues(alpha: 0.055),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _MarqueeHeading(),
          SizedBox(height: 13),
          _MarqueeLane(
            message: 'Saya Bangga Menjadi Mahasiswa IT',
            color: _teal,
            duration: Duration(seconds: 19),
            movesRightToLeft: true,
          ),
          _LaneDivider(),
          _MarqueeLane(
            message: 'Belajar, Berkarya, dan Menginspirasi',
            color: _sage,
            duration: Duration(seconds: 23),
            movesRightToLeft: false,
          ),
          _LaneDivider(),
          _MarqueeLane(
            message: 'Bersama Teknologi, Kita Membangun Masa Depan',
            color: _terracotta,
            duration: Duration(seconds: 27),
            movesRightToLeft: true,
          ),
        ],
      ),
    );
  }
}

class _MarqueeHeading extends StatelessWidget {
  const _MarqueeHeading();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _ivory,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(Icons.bolt_rounded, color: _terracotta, size: 19),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'A little inspiration for your journey',
            style: TextStyle(
              color: _charcoal,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Icon(Icons.more_horiz_rounded, color: _muted, size: 22),
      ],
    );
  }
}

class _LaneDivider extends StatelessWidget {
  const _LaneDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(height: 1, color: _sage.withValues(alpha: 0.18)),
    );
  }
}

class _MarqueeLane extends StatefulWidget {
  const _MarqueeLane({
    required this.message,
    required this.color,
    required this.duration, 
    required this.movesRightToLeft,
  });

  final String message;
  final Color color;
  final Duration duration;
  final bool movesRightToLeft;

  @override
  State<_MarqueeLane> createState() => _MarqueeLaneState();
}

class _MarqueeLaneState extends State<_MarqueeLane>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: widget.color,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );

    return SizedBox(
      height: 55,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final painter = TextPainter(
            text: TextSpan(text: widget.message, style: textStyle),
            textDirection: TextDirection.ltr,
            maxLines: 1,
          )..layout();
          const gap = 22.0;
          const separatorWidth = 9.0;
          final cycleWidth = painter.width + gap * 2 + separatorWidth;
          final cyclesPerHalf = math.max(
            2,
            (constraints.maxWidth / cycleWidth).ceil() + 1,
          );
          final halfWidth = cycleWidth * cyclesPerHalf;
          final itemWidth = cycleWidth;

          return ClipRect(
            child: AnimatedBuilder(
              animation: _controller,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(cyclesPerHalf * 2, (_) {
                  return _MarqueeItem(
                    message: widget.message,
                    color: widget.color,
                    style: textStyle,
                    gap: gap,
                    messageWidth: painter.width,
                    itemWidth: itemWidth,
                  );
                }),
              ),
              builder: (context, child) {
                final progress = _controller.value;
                final offset = widget.movesRightToLeft
                    ? -halfWidth * progress
                    : -halfWidth * (1 - progress);
                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: OverflowBox(
                    alignment: Alignment.centerLeft,
                    minWidth: halfWidth * 2,
                    maxWidth: halfWidth * 2,
                    child: SizedBox(width: halfWidth * 2, child: child),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _MarqueeItem extends StatelessWidget {
  const _MarqueeItem({
    required this.message,
    required this.color,
    required this.style,
    required this.gap,
    required this.messageWidth,
    required this.itemWidth,
  });

  final String message;
  final Color color;
  final TextStyle style;
  final double gap;
  final double messageWidth;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: Row(
        children: [
          SizedBox(width: gap),
          SizedBox(
            width: messageWidth,
            child: Text(
              message,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.clip,
              style: style,
            ),
          ),
          SizedBox(width: gap),
          SizedBox(
            width: 9,
            child: Center(
              child: Icon(
                Icons.circle,
                size: 7,
                color: color.withValues(alpha: 0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.eco_outlined, size: 16, color: _sage),
        SizedBox(width: 7),
        Text(
          'Learn with curiosity. Create with purpose.',
          style: TextStyle(
            color: _muted,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
