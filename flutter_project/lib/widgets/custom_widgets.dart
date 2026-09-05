import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/complaint_model.dart';
import 'package:intl/intl.dart';

class StatusBadge extends StatelessWidget {
  final ComplaintStatus status;

  const StatusBadge({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case ComplaintStatus.pending:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFD97706);
        label = 'Pending';
        break;
      case ComplaintStatus.verified:
        bg = const Color(0xFFDBEAFE);
        fg = const Color(0xFF2563EB);
        label = 'Verified';
        break;
      case ComplaintStatus.assigned:
        bg = const Color(0xFFEDE9FE);
        fg = const Color(0xFF7C3AED);
        label = 'Assigned';
        break;
      case ComplaintStatus.inProgress:
        bg = const Color(0xFFFFEDD5);
        fg = const Color(0xFFEA580C);
        label = 'In Action';
        break;
      case ComplaintStatus.resolved:
        bg = const Color(0xFFD1FAE5);
        fg = const Color(0xFF059669);
        label = 'Resolved';
        break;
      case ComplaintStatus.rejected:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFDC2626);
        label = 'Rejected';
        break;
      case ComplaintStatus.closed:
        bg = const Color(0xFFF3F4F6);
        fg = const Color(0xFF4B5563);
        label = 'Closed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white : AppColors.textPrimaryLight,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.primary, size: 20) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}

class ComplaintCardWidget extends StatelessWidget {
  final ComplaintModel complaint;
  final VoidCallback onTap;

  const ComplaintCardWidget({
    Key? key,
    required this.complaint,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateStr = DateFormat('dd MMM yyyy').format(complaint.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        complaint.complaintId,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StatusBadge(status: complaint.status),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  complaint.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  complaint.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : AppColors.textSecondaryLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${complaint.village}, ${complaint.taluk}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.calendar_today_outlined, size: 13, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      dateStr,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
