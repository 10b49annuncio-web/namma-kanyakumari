import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class ImagePickerCard extends StatelessWidget {
  final File? image;

  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  final VoidCallback? onRemove;

  final double height;

  const ImagePickerCard({
    super.key,
    this.image,
    required this.onCameraTap,
    required this.onGalleryTap,
    this.onRemove,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
      ),
      child: Column(
        children: [
          //---------------------------------------------
          // IMAGE PREVIEW
          //---------------------------------------------

          Container(
            height: height,
            width: double.infinity,
            color: AppColors.inputFill,
            child: image == null
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.image_outlined,
                        size: 70,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "No Image Selected",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              AppColors.textSecondary,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),

                      if (onRemove != null)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor:
                                Colors.black54,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: onRemove,
                            ),
                          ),
                        ),
                    ],
                  ),
          ),

          //---------------------------------------------
          // ACTION BUTTONS
          //---------------------------------------------

          Padding(
            padding: const EdgeInsets.all(
              AppSizes.defaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onCameraTap,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                    ),
                    label: const Text("Camera"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onGalleryTap,
                    icon: const Icon(
                      Icons.photo_library_outlined,
                    ),
                    label: const Text("Gallery"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}