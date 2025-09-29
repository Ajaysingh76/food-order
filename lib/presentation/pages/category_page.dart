import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/category/category_bloc.dart';
import '../../domain/models/menu_item.dart';
import '../theme/vibrant_bites_theme.dart';
import '../widgets/menu_item_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    // Load category data when page is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is String) {
        context.read<CategoryBloc>().add(CategoryItemsRequested(arguments));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    
    if (arguments == null || arguments is! String) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error', style: VibrantBites.headingLight),
          backgroundColor: VibrantBites.darkGrey,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: VibrantBites.mediumGrey),
              const SizedBox(height: 16),
              Text('Category not found', style: VibrantBites.bodyLarge),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
    
    final String category = arguments;
    
    return Scaffold(
      backgroundColor: VibrantBites.creamyOffWhite,
      appBar: AppBar(
        title: Text(category, style: VibrantBites.headingLight),
        backgroundColor: VibrantBites.darkGrey,
        foregroundColor: VibrantBites.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: VibrantBites.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          switch (state.status) {
            case CategoryStatus.initial:
              context.read<CategoryBloc>().add(CategoryItemsRequested(category));
              return const _CenteredLoader();
            case CategoryStatus.loading:
              return const _CenteredLoader();
            case CategoryStatus.failure:
              return _ErrorView(
                message: state.error?.message ?? 'Something went wrong',
                onRetry: () => context.read<CategoryBloc>().add(CategoryItemsRequested(category)),
              );
            case CategoryStatus.loaded:
              return _buildItemsList(context, state.items);
          }
        },
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, List<MenuItem> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64,
              color: VibrantBites.mediumGrey,
            ),
            const SizedBox(height: VibrantBites.elementSpacing),
            Text(
              'No items found in this category',
              style: VibrantBites.bodyLarge.copyWith(
                color: VibrantBites.mediumGrey,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(VibrantBites.screenPadding),
      child: Column(
        children: [
          const SizedBox(height: VibrantBites.elementSpacing),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: VibrantBites.elementSpacing),
            child: MenuItemCard(
              item: item,
              showCategoryTag: false, // Hide redundant category tag on category screen
              onTap: () => Navigator.of(context).pushNamed('/item_details', arguments: item),
            ),
          )).toList(),
          const SizedBox(height: 100), // Bottom padding for safe area
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: VibrantBites.mediumGrey,
          ),
          const SizedBox(height: VibrantBites.elementSpacing),
          Text(message, style: VibrantBites.bodyLarge),
          const SizedBox(height: VibrantBites.elementSpacing),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _CenteredLoader extends StatelessWidget {
  const _CenteredLoader();
  
  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(
      color: VibrantBites.boldOrangeRed,
    ),
  );
}
