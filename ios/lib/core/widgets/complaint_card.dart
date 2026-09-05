import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class ComplaintCard extends StatelessWidget {
  final String complaintId;
  final String category;
  final String location;
  final String date;
  final String status;

  final String image;

  final VoidCallback? onTap;

  const ComplaintCard({
    super.key,
    required this.complaintId,
    required this.category,
    required this.location,
    required this.date,
    required this.status,
    required this.image,
    this.onTap,
  });

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case "submitted":
        return Colors.blue;

      case "verified":
        return Colors.teal;

      case "assigned":
        return Colors.orange;

      case "in progress":
        return Colors.deepOrange;

      case "resolved":
        return Colors.green;

      case "closed":
        return Colors.grey;

      default:
        return AppColors.primary;
    }
  }

  IconData getStatusIcon() {
    switch (status.toLowerCase()) {
      case "submitted":
        return Icons.upload_file;

      case "verified":
        return Icons.verified;

      case "assigned":
        return Icons.assignment;

      case "in progress":
        return Icons.engineering;

      case "resolved":
        return Icons.check_circle;

      case "closed":
        return Icons.lock;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor();

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
        onTap: onTap,

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            //---------------------------------------------------
            // IMAGE
            //---------------------------------------------------

            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(22),
              ),

              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            //---------------------------------------------------
            // CONTENT
            //---------------------------------------------------

            Padding(
              padding: const EdgeInsets.all(
                AppSizes.defaultPadding,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: statusColor
                              .withOpacity(.12),

                          borderRadius:
                              BorderRadius.circular(30),
                        ),

                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            Icon(
                              getStatusIcon(),
                              color: statusColor,
                              size: 16,
                            ),

                            const SizedBox(width: 5),

                            Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [

                      const Icon(
                        Icons.confirmation_number,
                        color: AppColors.primary,
                        size: 18,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        complaintId,
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.red,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(location),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: AppColors.primary,
                      ),

                      const SizedBox(width: 8),

                      Text(date),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      onPressed: onTap,

                      icon: const Icon(
                        Icons.visibility,
                      ),

                      label: const Text(
                        "View Details",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}