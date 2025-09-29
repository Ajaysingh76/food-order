import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/restaurant_list/restaurant_list_bloc.dart';
import '../../domain/models/restaurant.dart';
import '../theme/vibrant_bites_theme.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/discount_banner.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_icon.dart';
import '../widgets/restaurant_card_vibrant.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  int _currentNavIndex = 0;
  String _selectedCategory = 'Burger';
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.lunch_dining, 'label': 'Burger'},
    {'icon': Icons.restaurant, 'label': 'Steak'},
    {'icon': Icons.set_meal, 'label': 'Sea Food'},
    {'icon': Icons.local_pizza, 'label': 'Pizza'},
    {'icon': Icons.cake, 'label': 'Desserts'},
  ];

  @override
  void initState() {
    super.initState();
    // Immediately trigger restaurant data loading when the page is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantListBloc>().add(RestaurantListRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: BlocBuilder<RestaurantListBloc, RestaurantListState>(
        builder: (context, state) {
          switch (state.status) {
            case RestaurantListStatus.initial:
              return const _CenteredLoader();
            case RestaurantListStatus.loading:
              return const _CenteredLoader();
            case RestaurantListStatus.failure:
              return _ErrorView(
                message: state.error?.message ?? 'Something went wrong',
                onRetry: () => context.read<RestaurantListBloc>().add(RestaurantListRetry()),
              );
            case RestaurantListStatus.loaded:
              return _buildBody(state.restaurants);
          }
        },
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: VibrantBites.darkGrey,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [VibrantBites.darkGrey, VibrantBites.jetBlack.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.network(
                  'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&h=600&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: VibrantBites.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(VibrantBites.overlayButtonRadius),
          ),
          child: const Icon(Icons.menu, color: VibrantBites.white, size: 20),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: VibrantBites.boldOrangeRed,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Delivery location',
                style: VibrantBites.bodySmall.copyWith(
                  color: VibrantBites.mediumGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            '351 Maison Street, NY',
            style: VibrantBites.headingLight.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: VibrantBites.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(VibrantBites.overlayButtonRadius),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: VibrantBites.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(List<Restaurant> restaurants) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + VibrantBites.elementSpacing),
          const DiscountBanner(),
          const SizedBox(height: VibrantBites.sectionSpacing),
          const SearchBarWidget(),
          const SizedBox(height: VibrantBites.sectionSpacing),
          _buildCategorySection(),
          const SizedBox(height: VibrantBites.sectionSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: VibrantBites.screenPadding),
            child: Text(
              'Popular restaurants',
              style: VibrantBites.headingBold,
            ),
          ),
          const SizedBox(height: VibrantBites.elementSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: VibrantBites.screenPadding),
            child: Column(
              children: restaurants.map((restaurant) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: VibrantBites.elementSpacing),
                  child: RestaurantCardVibrant(
                    restaurant: restaurant,
                    onTap: () => Navigator.of(context).pushNamed('/menu', arguments: restaurant),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 100), // Bottom padding for nav bar
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: VibrantBites.screenPadding),
          child: Text(
            'Categories',
            style: VibrantBites.headingBold,
          ),
        ),
        const SizedBox(height: VibrantBites.elementSpacing),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: VibrantBites.screenPadding),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == _categories.length - 1 ? 0 : VibrantBites.elementSpacing,
                ),
                child: CategoryIcon(
                  icon: category['icon'],
                  label: category['label'],
                  isSelected: _selectedCategory == category['label'],
                  onTap: () {
                    setState(() => _selectedCategory = category['label']);
                    Navigator.of(context).pushNamed('/category', arguments: category['label']);
                  },
                ),
              );
            },
          ),
        ),
      ],
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
          Text(message, style: VibrantBites.bodyLarge),
          const SizedBox(height: VibrantBites.smallSpacing),
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
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}
