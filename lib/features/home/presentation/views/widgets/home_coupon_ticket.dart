import 'package:deals/core/utils/app_colors.dart';
import 'package:deals/core/utils/app_images.dart';
import 'package:deals/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/widgets/coupon_ticket/ticket_container.dart';
import '../../../../../core/widgets/coupon_ticket/dashed_line_painter.dart';
import 'package:cached_network_image/cached_network_image.dart'; // <-- new

/// A specialized coupon widget that uses [TicketContainer].
/// This widget takes coupon-related data and uses the ticket container to display it.
/// The dashed line is drawn after the leading widget to create a more cohesive design.
class HomeCouponTicket extends StatelessWidget {
  final String title;
  final num? discountValue;
  final String? imageUrl;
  final DateTime? expiryDate;

  /// Sizing
  final double? width;
  final double? height;

  /// Callback for the trailing icon button
  final VoidCallback? onPressed;

  const HomeCouponTicket({
    super.key,
    required this.title,
    this.discountValue,
    this.imageUrl,
    this.expiryDate,
    this.width,
    this.height = 120,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: TicketContainer(
        holeRadius: 16,
        dashedLinePainter: const DashedLinePainter(
          dashHeight: 8,
          dashSpace: 4,
          strokeWidth: 2,
          color: Colors.black,
        ),
        centerLine: true, // places the dashed line between leading & child
        spacing: 25,
        width: width,
        height: height,
        leading: _buildLeadingImage(),
        child: _buildCouponInfo(),
      ),
    );
  }

  Widget _buildLeadingImage() {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 80, maxHeight: 80),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              fit: BoxFit.contain,
              placeholder: (ctx, url) => Skeletonizer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 66,
                    height: 66,
                    color: AppColors.lightGray,
                  ),
                ),
              ),
              errorWidget: (ctx, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppImages.assetsImagesTest3,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCouponInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 28,
        ),
        Text(
          title.isNotEmpty ? title : 'Placeholder Title',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          '${discountValue ?? 0}% OFF',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          expiryDate != null
              ? 'Valid until ${DateFormat('d MMM').format(expiryDate!)}'
              : 'Valid until ...',
          style: AppTextStyles.regular12.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}
