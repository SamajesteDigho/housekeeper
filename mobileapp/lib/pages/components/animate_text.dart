import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    super.key,
    required this.text,
    required this.animationType,
    this.textColor = Colors.white,
    this.textSize = 30,
    this.bold = false,
    this.repeat = true,
  });
  final String text;
  final AnimationType animationType;
  final Color textColor;
  final double textSize;
  final bool bold;
  final bool repeat;

  @override
  State<AnimatedText> createState() => _AnimatedText();
}

class _AnimatedText extends State<AnimatedText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: widget.animationType == AnimationType.typerAnimation
          ? [typerAnimation(widget.text)]
          : widget.animationType == AnimationType.scaleAnimation
              ? [scaleAnimation(widget.text)]
              : widget.animationType == AnimationType.fadeAnimation
                  ? [fadeAnimation(widget.text)]
                  : widget.animationType == AnimationType.rotateAnimation
                      ? [rotateAnimation(widget.text)]
                      : [waveAnimation(widget.text)],
      repeatForever: widget.repeat,
      stopPauseOnTap: false,
    );
  }

  waveAnimation(String text) {
    return WavyAnimatedText(
      widget.text,
      textStyle: TextStyle(
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  scaleAnimation(String text) {
    return ScaleAnimatedText(
      widget.text,
      textStyle: TextStyle(
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
      ),
      duration: const Duration(seconds: 4),
    );
  }

  typerAnimation(String text) {
    return TyperAnimatedText(
      widget.text,
      textStyle: TextStyle(
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }

  fadeAnimation(String text) {
    return FadeAnimatedText(
      widget.text,
      textStyle: TextStyle(
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  rotateAnimation(String text) {
    return RotateAnimatedText(
      widget.text,
      textStyle: TextStyle(
        color: widget.textColor,
        fontSize: widget.textSize,
        fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

enum AnimationType { wavyAnimation, fadeAnimation, scaleAnimation, typerAnimation, rotateAnimation }
