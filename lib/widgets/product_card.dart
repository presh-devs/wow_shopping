import 'package:flutter/material.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/features/product_details/product_page.dart';
import 'package:wow_shopping/models/product_item.dart';
import 'package:wow_shopping/widgets/common.dart';
import 'package:wow_shopping/widgets/wishlist_button/wishlist_button.dart';

@immutable
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.item,
    this.onPressed,
  });

  final ProductItem item;
  final ValueChanged<ProductItem>? onPressed;

  void _defaultOnPressed(BuildContext context) {
    Navigator.of(context).push(ProductPage.route(item));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: appButtonRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed != null //
            ? () => onPressed!(item)
            : () => _defaultOnPressed(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Positioned.fill(
                    child: Ink.image(
                      image: AssetImage(item.primaryPhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                  WishlistButton(item: item),
                ],
              ),
            ),
            verticalMargin4,
            Padding(
              padding: horizontalPadding4,
              child: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding: horizontalPadding4,
              child: Text(
                item.subTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: AppTheme.of(context).appColorLight,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: allPadding4,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.formattedPrice,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.formattedPriceWithTax,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
