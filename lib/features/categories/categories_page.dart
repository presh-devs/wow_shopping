import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/features/categories/cubit/categories_page_cubit.dart';
import 'package:wow_shopping/widgets/app_icon.dart';
import 'package:wow_shopping/widgets/category_nav_list.dart';
import 'package:wow_shopping/widgets/common.dart';
import 'package:wow_shopping/widgets/sliver_expansion_tile.dart';
import 'package:wow_shopping/widgets/top_nav_bar.dart';

@immutable
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesPageCubit(),
      child: const CategoriesPageContent(),
    );
  }
}

class CategoriesPageContent extends StatelessWidget {
  const CategoriesPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesPageCubit, CategoriesPageState>(
      builder: (context, state) {
        return SizedBox.expand(
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopNavBar(
                  title: const Text('Categories'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        // FIXME: perform search
                      },
                      icon: const AppIcon(iconAsset: Assets.iconSearch),
                    ),
                  ],
                  bottom: CategoryNavList(
                    selected: state.selectedCategory,
                    onCategoryItemPressed: (value) => context
                        .read<CategoriesPageCubit>()
                        .onCategoryItemPressed(value),
                  ),
                ),
                Expanded(
                  child: SliverExpansionTileHost(
                    child: CustomScrollView(
                      slivers: [
                        for (final item in CategoryItem.values) ...[
                          SliverCategoryHeader(item: item),
                          SliverCategoryContent(item: item),
                        ],
                      ],
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

@immutable
class SliverCategoryHeader extends StatelessWidget {
  
  const SliverCategoryHeader({
    super.key,
    required this.item,
  });

  final CategoryItem item;

  @override
  Widget build(BuildContext context) {
        return SliverExpansionTileHeader(
          section: item.name,
          builder: (BuildContext context, String section, bool expanded) {
            return Padding(
              padding: horizontalPadding24 + verticalPadding16,
              child: Row(
                children: [
                  AppIcon(iconAsset: item.iconAsset),
                  horizontalMargin16,
                  Text(item.title),
                  horizontalMargin16,
                  const Spacer(),
                  ExpansionTileChevron(section: item.name),
                ],
              ),
            );
          },
        );
      
  }
}

@immutable
class SliverCategoryContent extends StatelessWidget {
  const SliverCategoryContent({
    super.key,
    required this.item,
  });

  final CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return SliverExpansionTileContent(
      section: item.name,
      sliverBuilder: (BuildContext context) {
        return SliverPadding(
          padding: horizontalPadding8,
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: 30,
              (BuildContext context, int index) {
                return const Padding(
                  padding: allPadding8,
                  child: Placeholder(color: Colors.black26),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
