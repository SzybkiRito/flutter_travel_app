import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class SnackbarController {
  String _getLabelBasedOnType(SnackbarTypes type) {
    switch (type) {
      case SnackbarTypes.success:
        return 'Success';
      case SnackbarTypes.error:
        return 'Oops! Something went wrong.';
      default:
        return '';
    }
  }

  Color _getBackgroundColorBasedOnType(SnackbarTypes type) {
    switch (type) {
      case SnackbarTypes.success:
        return AppColors.kDefaultLightGreenColor;
      case SnackbarTypes.error:
        return AppColors.kDefaultRedColor;
      default:
        return Colors.white;
    }
  }

  Color _getAssetColorBasedOnType(SnackbarTypes type) {
    switch (type) {
      case SnackbarTypes.success:
        return AppColors.kDefaultDarkGreenColor;
      case SnackbarTypes.error:
        return AppColors.kDefaultDarkRedColor;
      default:
        return Colors.white;
    }
  }

  void showSnackbar({
    required BuildContext context,
    required String message,
    required SnackbarTypes type,
  }) {
    final snackbar = SnackBar(
      backgroundColor: Colors.white,
      content: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: DefaultStylesConfig.kDefaultSnackbarHeight,
            decoration: BoxDecoration(
              color: _getBackgroundColorBasedOnType(type),
              borderRadius: BorderRadius.circular(
                18.0,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 40.0,
                ),
                const SizedBox(width: 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          _getLabelBasedOnType(type),
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18.0, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: SvgPicture.asset(
                'assets/icons/bubbles.svg',
                height: 48,
                width: 48,
                colorFilter: ColorFilter.mode(
                  _getAssetColorBasedOnType(type),
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void closeSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void closeAllSnackbars(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
