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
    this.style,
  });
  final String text;
  final AnimationType animationType;
  final Color textColor;
  final double textSize;
  final bool bold;
  final bool repeat;
  final TextStyle? style;

  @override
  State<AnimatedText> createState() => _AnimatedText();
}

class _AnimatedText extends State<AnimatedText> {
  @override
  Widget build(BuildContext context) {
    TextStyle animationTextStyle = widget.style ??
        TextStyle(
          color: widget.textColor,
          fontSize: widget.textSize,
          fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
        );
    return AnimatedTextKit(
      animatedTexts: widget.animationType == AnimationType.typerAnimation
          ? [typerAnimation(widget.text, animationTextStyle)]
          : widget.animationType == AnimationType.scaleAnimation
              ? [scaleAnimation(widget.text, animationTextStyle)]
              : widget.animationType == AnimationType.fadeAnimation
                  ? [fadeAnimation(widget.text, animationTextStyle)]
                  : widget.animationType == AnimationType.rotateAnimation
                      ? [rotateAnimation(widget.text, animationTextStyle)]
                      : [waveAnimation(widget.text, animationTextStyle)],
      repeatForever: widget.repeat,
      stopPauseOnTap: false,
    );
  }

  waveAnimation(String text, TextStyle style) {
    return WavyAnimatedText(
      widget.text,
      textStyle: style,
    );
  }

  scaleAnimation(String text, TextStyle style) {
    return ScaleAnimatedText(
      widget.text,
      textStyle: style,
      duration: const Duration(seconds: 4),
    );
  }

  typerAnimation(String text, TextStyle style) {
    return TyperAnimatedText(
      widget.text,
      textStyle: style,
      speed: const Duration(milliseconds: 100),
    );
  }

  fadeAnimation(String text, TextStyle style) {
    return FadeAnimatedText(
      widget.text,
      textStyle: style,
    );
  }

  rotateAnimation(String text, TextStyle style) {
    return RotateAnimatedText(
      widget.text,
      textStyle: style,
    );
  }
}

enum AnimationType { wavyAnimation, fadeAnimation, scaleAnimation, typerAnimation, rotateAnimation }
