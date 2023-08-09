import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:wow_shopping/models/product_item.dart';
import 'package:wow_shopping/widgets/app_icon.dart';

@immutable
class WishlistButton extends StatelessWidget {
  const WishlistButton({
    super.key,
    required this.item,
  });

  final ProductItem item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit(context.wishlistRepo),
      child: WishlistButtonContent(item: item),
    );
  }
}

class WishlistButtonContent extends StatelessWidget {
  const WishlistButtonContent({
    super.key,
    required this.item,
  });

  final ProductItem item;

  @override
  Widget build(BuildContext context) {
    void onTogglePressed(bool inWishlist) {
      if (inWishlist) {
        context.read<WishlistCubit>().addItem(item);
      } else {
        context.read<WishlistCubit>().removeItem(item);
      }
    }

    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final inWishlist = (state as WishlistPopulated).inWishlist(item);
        return IconButton(
          onPressed: () => onTogglePressed(!inWishlist),
          icon: AppIcon(
            iconAsset: inWishlist 
                ? Assets.iconHeartFilled
                : Assets.iconHeartEmpty,
            color: inWishlist 
                ? AppTheme.of(context).appColor
                : const Color(0xFFD0D0D0),
          ),
        );
      },
    );
  }
}
