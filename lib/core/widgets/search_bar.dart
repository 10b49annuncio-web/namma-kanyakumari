import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onFilterTap;
  final VoidCallback? onClear;

  final bool showFilter;
  final bool enabled;
  final bool autofocus;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.onClear,
    this.showFilter = false,
    this.enabled = true,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            autofocus: autofocus,

            textInputAction: TextInputAction.search,

            onChanged: onChanged,
            onSubmitted: onSubmitted,

            decoration: InputDecoration(
              hintText: hintText,

              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.primary,
              ),

              suffixIcon: controller != null &&
                      controller!.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller!.clear();

                        if (onClear != null) {
                          onClear!();
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.grey,
                      ),
                    )
                  : null,

              filled: true,
              fillColor: AppColors.inputFill,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.textFieldRadius,
                ),
                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.textFieldRadius,
                ),
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.textFieldRadius,
                ),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),

        if (showFilter) ...[
          const SizedBox(width: 12),

          InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(
                  AppSizes.buttonRadius,
                ),
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ]
      ],
    );
  }
}