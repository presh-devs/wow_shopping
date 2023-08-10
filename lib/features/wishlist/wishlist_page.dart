import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/features/wishlist/cubit/wishlist_page_cubit.dart';
import 'package:wow_shopping/features/wishlist/widgets/wishlist_item.dart';
import 'package:wow_shopping/widgets/app_button.dart';
import 'package:wow_shopping/widgets/common.dart';
import 'package:wow_shopping/widgets/top_nav_bar.dart';

@immutable
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistPageCubit(context.wishlistRepo),
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
    return BlocBuilder<WishlistPageCubit, WishlistPageState>(
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
                          .read<WishlistPageCubit>()
                          .toggleSelectAll(),
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

                        return Padding(
                          padding: verticalPadding12,
                          child: WishlistItem(
                              item: item,
                              onPressed: (item) {
                                // FIXME: navigate to product details
                              },
                              selected: context
                                  .read<WishlistPageCubit>()
                                  .selectItems(item),
                              onToggleSelection: (item, isToggled) => context
                                  .read<WishlistPageCubit>() //
                                  .setSelected(item, isToggled)),
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
                    heightFactor: state.selectedItems.isEmpty ? 0.0 : 1.0,
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
                                    .read<WishlistPageCubit>()
                                    .removeSelectedItems(state.selectedItems),
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
