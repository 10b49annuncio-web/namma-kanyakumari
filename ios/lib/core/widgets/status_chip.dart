import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

enum ComplaintStatus {
  submitted,
  verified,
  assigned,
  inProgress,
  resolved,
  rejected,
  closed,
}

class StatusChip extends StatelessWidget {
  final ComplaintStatus status;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  const StatusChip({
    super.key,
    required this.status,
    this.fontSize = 13,
    this.padding,
  });

  Color get backgroundColor {
    switch (status) {
      case ComplaintStatus.submitted:
        return AppColors.submitted.withOpacity(.12);

      case ComplaintStatus.verified:
        return AppColors.verified.withOpacity(.12);

      case ComplaintStatus.assigned:
        return AppColors.assigned.withOpacity(.12);

      case ComplaintStatus.inProgress:
        return AppColors.inProgress.withOpacity(.12);

      case ComplaintStatus.resolved:
        return AppColors.resolved.withOpacity(.12);

      case ComplaintStatus.rejected:
        return AppColors.error.withOpacity(.12);

      case ComplaintStatus.closed:
        return AppColors.closed.withOpacity(.12);
    }
  }

  Color get textColor {
    switch (status) {
      case ComplaintStatus.submitted:
        return AppColors.submitted;

      case ComplaintStatus.verified:
        return AppColors.verified;

      case ComplaintStatus.assigned:
        return AppColors.assigned;

      case ComplaintStatus.inProgress:
        return AppColors.inProgress;

      case ComplaintStatus.resolved:
        return AppColors.resolved;

      case ComplaintStatus.rejected:
        return AppColors.error;

      case ComplaintStatus.closed:
        return AppColors.closed;
    }
  }

  IconData get icon {
    switch (status) {
      case ComplaintStatus.submitted:
        return Icons.upload_file_rounded;

      case ComplaintStatus.verified:
        return Icons.verified_rounded;

      case ComplaintStatus.assigned:
        return Icons.assignment_rounded;

      case ComplaintStatus.inProgress:
        return Icons.engineering_rounded;

      case ComplaintStatus.resolved:
        return Icons.check_circle_rounded;

      case ComplaintStatus.rejected:
        return Icons.cancel_rounded;

      case ComplaintStatus.closed:
        return Icons.lock_rounded;
    }
  }

  String get label {
    switch (status) {
      case ComplaintStatus.submitted:
        return "Submitted";

      case ComplaintStatus.verified:
        return "Verified";

      case ComplaintStatus.assigned:
        return "Assigned";

      case ComplaintStatus.inProgress:
        return "In Progress";

      case ComplaintStatus.resolved:
        return "Resolved";

      case ComplaintStatus.rejected:
        return "Rejected";

      case ComplaintStatus.closed:
        return "Closed";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: textColor.withOpacity(.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}