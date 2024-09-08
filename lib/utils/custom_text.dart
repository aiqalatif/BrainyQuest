import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;

  final Key? textKey;
  final TextOverflow? overflow;
  final double? stepGranularity;
  final List<double>? presetFontSizes;
  final double? textScaleFactor;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final bool wrapWords;
  final AutoSizeGroup? group;
  final bool? softWrap;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const CText({
    Key? key,
    required this.text,
    this.style,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.fontStyle,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.textKey,
    this.overflow = TextOverflow.ellipsis,
    this.stepGranularity,
    this.presetFontSizes,
    this.textScaleFactor,
    this.locale,
    this.strutStyle,
    this.wrapWords = true,
    this.group,
    this.softWrap,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = style?.copyWith(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
        ) ??
        TextStyle(
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          fontSize: fontSize,
          fontStyle: fontStyle,
        );

    return AutoSizeText(
      text,
      style: textStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      key: textKey,
      overflow: overflow,
      stepGranularity: stepGranularity ?? 1.0,
      presetFontSizes: presetFontSizes,
      textScaleFactor: textScaleFactor,
      locale: locale,
      strutStyle: strutStyle,
      wrapWords: wrapWords,
      group: group,
      softWrap: softWrap,
    );
  }
}
