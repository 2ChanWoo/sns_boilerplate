import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';

class _SvgAsset extends StatelessWidget {
  const _SvgAsset(
      this.assetPath, {
        this.width,
        this.height,
        this.color,
        Key? key,
      }) : super(key: key);

  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/$assetPath',
      width: width,
      height: height,
      color: color,
    );
  }
}

class OpeningQuoteSvgAsset extends StatelessWidget {
  const OpeningQuoteSvgAsset({
    this.width,
    this.height,
    this.color,
    Key? key,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _SvgAsset(
      'opening-quote.svg',
      width: width,
      height: height,
      color: theme.quoteSvgColor,
    );
  }
}

class ClosingQuoteSvgAsset extends StatelessWidget {
  const ClosingQuoteSvgAsset({
    this.width,
    this.height,
    this.color,
    Key? key,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _SvgAsset(
      'closing-quote.svg',
      width: width,
      height: height,
      color: theme.quoteSvgColor,
    );
  }
}
