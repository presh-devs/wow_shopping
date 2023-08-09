import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:wow_shopping/features/wishlist/widgets/wishlist_item.dart';
import 'package:wow_shopping/models/product_item.dart';
import 'package:wow_shopping/widgets/app_button.dart';
import 'package:wow_shopping/widgets/common.dart';
import 'package:wow_shopping/widgets/top_nav_bar.dart';

@immutable
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit(context.wishlistRepo),
      child: const WishlistPageContent(),
    );
  }
}

class WishlistPageContent extends StatelessWidget {
  const WishlistPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
  
        return SizedBox.expand(
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopNavBar(
                  title: const Text('Wishlist'),
                  actions: [
                    TextButton(
                      onPressed: () => context
                          .read<WishlistCubit>()
                          .toggleSelectAll( (state as WishlistPopulated).selectedItems!),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Select All'),
                    ),
                  ],
                ),
                Expanded(
                  child: MediaQuery.removeViewPadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      padding: verticalPadding12,
                      itemCount:
                          context.wishlistRepo.currentWishlistItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item =
                            context.wishlistRepo.currentWishlistItems[index];
                        bool selected =
                            context.read<WishlistCubit>().selectItems(item);
                        return Padding(
                          padding: verticalPadding12,
                          child: WishlistItem(
                            item: item,
                            onPressed: (item) {
                              // FIXME: navigate to product details
                            },
                            selected: !context
                                .read<WishlistCubit>()
                                .selectItems(item),
                            onToggleSelection: context
                                .read<WishlistCubit>()
                                .setSelected(item, selected),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  alignment: Alignment.topCenter,
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor:  (state as WishlistPopulated).selectedItems!.isEmpty ? 0.0 : 1.0,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: appLightGreyColor,
                        border: Border(
                          top: BorderSide(color: appDividerColor, width: 2.0),
                        ),
                      ),
                      child: Padding(
                        padding: allPadding24,
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                onPressed: () => context
                                    .read<WishlistCubit>()
                                    .removeSelectedItems( (state).selectedItems!),
                                label: 'Remove',
                                iconAsset: Assets.iconRemove,
                              ),
                            ),
                            horizontalMargin16,
                            Expanded(
                              child: AppButton(
                                onPressed: () {
                                  // FIXME: implement Buy Now button
                                },
                                label: 'Buy now',
                                iconAsset: Assets.iconBuy,
                                style: AppButtonStyle.highlighted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// @immutable
// class WishlistConsumer extends StatelessWidget {
//   const WishlistConsumer({
//     super.key,
//     required this.builder,
//   });

//   final Widget Function(BuildContext context, List<ProductItem> wishlist)
//       builder;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<ProductItem>>(
//       initialData: context.wishlistRepo.currentWishlistItems,
//       stream: context.wishlistRepo.streamWishlistItems,
//       builder:
//           (BuildContext context, AsyncSnapshot<List<ProductItem>> snapshot) {
//         return builder(context, snapshot.requireData);
//       },
//     );
//   }
// }
