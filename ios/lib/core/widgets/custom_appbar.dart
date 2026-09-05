import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  final bool showBackButton;

  final bool centerTitle;

  final bool showNotification;

  final bool showSearch;

  final bool showProfile;

  final List<Widget>? actions;

  final VoidCallback? onBack;

  final VoidCallback? onSearch;

  final VoidCallback? onNotification;

  final VoidCallback? onProfile;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.centerTitle = true,
    this.showNotification = false,
    this.showSearch = false,
    this.showProfile = false,
    this.actions,
    this.onBack,
    this.onSearch,
    this.onNotification,
    this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      centerTitle: centerTitle,

      backgroundColor: AppColors.white,

      surfaceTintColor: Colors.transparent,

      automaticallyImplyLeading: false,

      leading: showBackButton
          ? IconButton(
              onPressed: onBack ??
                  () {
                    Navigator.pop(context);
                  },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary,
              ),
            )
          : null,

      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: [
        if (showSearch)
          IconButton(
            onPressed: onSearch,
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.primary,
            ),
          ),

        if (showNotification)
          IconButton(
            onPressed: onNotification,
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primary,
            ),
          ),

        if (showProfile)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: onProfile,
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}