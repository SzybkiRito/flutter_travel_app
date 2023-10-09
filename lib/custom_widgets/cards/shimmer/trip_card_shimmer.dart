import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class TripCardShimmer extends StatelessWidget {
  const TripCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.kDefaultBaseShimmerColor,
      highlightColor: AppColors.kDefaultHighlightShimmerColor,
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
                topRight: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
                bottomRight: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
