import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoader({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              borderRadius ?? BorderRadius.circular(12),
        ),
      ),
    );
  }
}

///----------------------------------------------------------
/// Complaint Card Shimmer
///----------------------------------------------------------

class ComplaintCardShimmer extends StatelessWidget {
  const ComplaintCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLoader(
              height: 180,
            ),

            const SizedBox(height: 16),

            const ShimmerLoader(
              width: 180,
              height: 22,
            ),

            const SizedBox(height: 12),

            const ShimmerLoader(),

            const SizedBox(height: 10),

            const ShimmerLoader(width: 220),

            const SizedBox(height: 10),

            const ShimmerLoader(width: 120),

            const SizedBox(height: 20),

            const ShimmerLoader(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}

///----------------------------------------------------------
/// Dashboard Card Shimmer
///----------------------------------------------------------

class DashboardCardShimmer extends StatelessWidget {
  const DashboardCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics:
          const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (_, __) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                ShimmerLoader(
                  width: 60,
                  height: 60,
                ),

                SizedBox(height: 16),

                ShimmerLoader(
                  width: 80,
                ),

                SizedBox(height: 8),

                ShimmerLoader(
                  width: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///----------------------------------------------------------
/// List Shimmer
///----------------------------------------------------------

class ListShimmer extends StatelessWidget {
  final int itemCount;

  const ListShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) =>
          const ComplaintCardShimmer(),
    );
  }
}