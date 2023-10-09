import 'package:flutter/material.dart';
import 'package:travel_planning_app/default_styles_config.dart';

class CustomTopNavgationBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopNavgationBar({
    super.key,
    required this.title,
    required this.onLeadingIconButtonTap,
    required this.onTrailingIconButtonTap,
    required this.isBackButtonVisible,
  });
  final String title;
  final VoidCallback onLeadingIconButtonTap;
  final VoidCallback onTrailingIconButtonTap;
  final bool isBackButtonVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      leading: Visibility(
        visible: isBackButtonVisible,
        child: IconButton(
          onPressed: onLeadingIconButtonTap,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onTrailingIconButtonTap,
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.black,
          ),
        ),
      ],
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(DefaultStylesConfig.kDefaultAppBarHeight),
        child: Container(
          color: Colors.grey[300],
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DefaultStylesConfig.kDefaultAppBarHeight);
}
