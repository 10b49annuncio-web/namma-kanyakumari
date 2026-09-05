import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

class CustomDialog {
  CustomDialog._();

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,

    String confirmText = "OK",
    String cancelText = "Cancel",

    bool showCancel = true,
    bool barrierDismissible = true,

    IconData? icon,
    Color? iconColor,

    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.cardRadius,
            ),
          ),

          contentPadding: const EdgeInsets.all(
            AppSizes.defaultPadding,
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              if (icon != null)
                CircleAvatar(
                  radius: 34,
                  backgroundColor:
                      (iconColor ?? AppColors.primary)
                          .withOpacity(.12),

                  child: Icon(
                    icon,
                    size: 36,
                    color:
                        iconColor ?? AppColors.primary,
                  ),
                ),

              if (icon != null)
                const SizedBox(height: 20),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [

                  if (showCancel)
                    Expanded(
                      child: SecondaryButton(
                        text: cancelText,
                        onPressed: () {

                          Navigator.pop(
                            context,
                            false,
                          );

                          onCancel?.call();
                        },
                      ),
                    ),

                  if (showCancel)
                    const SizedBox(width: 12),

                  Expanded(
                    child: PrimaryButton(
                      text: confirmText,
                      onPressed: () {

                        Navigator.pop(
                          context,
                          true,
                        );

                        onConfirm?.call();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //----------------------------------------------------------
  // SUCCESS
  //----------------------------------------------------------

  static Future<bool?> success({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      icon: Icons.check_circle,
      iconColor: AppColors.success,
      showCancel: false,
      confirmText: "Done",
    );
  }

  //----------------------------------------------------------
  // ERROR
  //----------------------------------------------------------

  static Future<bool?> error({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      icon: Icons.error,
      iconColor: AppColors.error,
      showCancel: false,
      confirmText: "OK",
    );
  }

  //----------------------------------------------------------
  // WARNING
  //----------------------------------------------------------

  static Future<bool?> warning({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      icon: Icons.warning_amber_rounded,
      iconColor: AppColors.warning,
      confirmText: "Continue",
      cancelText: "Cancel",
      onConfirm: onConfirm,
    );
  }

  //----------------------------------------------------------
  // DELETE
  //----------------------------------------------------------

  static Future<bool?> delete({
    required BuildContext context,
    String title = "Delete",
    String message =
        "Are you sure you want to delete this item?",
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      icon: Icons.delete_forever,
      iconColor: AppColors.error,
      confirmText: "Delete",
      cancelText: "Cancel",
      onConfirm: onConfirm,
    );
  }

  //----------------------------------------------------------
  // LOGOUT
  //----------------------------------------------------------

  static Future<bool?> logout({
    required BuildContext context,
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: "Logout",
      message:
          "Are you sure you want to logout?",
      icon: Icons.logout,
      iconColor: AppColors.warning,
      confirmText: "Logout",
      cancelText: "Stay",
      onConfirm: onConfirm,
    );
  }
}