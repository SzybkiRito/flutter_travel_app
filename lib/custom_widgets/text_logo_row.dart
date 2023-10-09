import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextLogoRow extends StatelessWidget {
  const TextLogoRow({
    super.key,
    required this.logoPath,
    required this.appName,
  });
  final String logoPath;
  final String appName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          logoPath,
          width: 32.0,
          height: 32.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          appName,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    );
  }
}
