import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// Small wrapper around AutoSizeText so screens can use one reusable text API.
class ReusableAutoSizeText extends StatelessWidget {
  const ReusableAutoSizeText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 1,
    this.minFontSize = 12,
    this.overflow = TextOverflow.ellipsis,
    this.stepGranularity = 1,
    this.presetFontSizes,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int maxLines;
  final double minFontSize;
  final TextOverflow overflow;
  final double stepGranularity;
  final List<double>? presetFontSizes;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      minFontSize: minFontSize,
      overflow: overflow,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
    );
  }
}
