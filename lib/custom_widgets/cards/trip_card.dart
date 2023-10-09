import 'package:flutter/material.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.onTap,
    required this.cityName,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
  });
  final VoidCallback onTap;
  final String cityName;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kDefaultDarkBlueColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
                topRight: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kDefaultLightBlueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
                bottomRight: Radius.circular(
                  DefaultStylesConfig.kDefaultBorderRadius,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DefaultStylesConfig.kDefaultPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trip to $cityName',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        "${endDate.difference(startDate).inDays} days",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 16,
                          ),
                          Text(
                            '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.kDefaultDarkBlueColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
