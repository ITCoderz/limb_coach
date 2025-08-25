import 'package:flutter/material.dart';
import 'package:mylimbcoach/utils/constants.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Constants.tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= Constants.desktop &&
      MediaQuery.of(context).size.width >= Constants.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width <= Constants.largeDesktop &&
      MediaQuery.of(context).size.width >= Constants.desktop;
  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > Constants.largeDesktop;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if (_size.width >= Constants.desktop) {
      return desktop;
    } else if (_size.width >= Constants.tablet && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
