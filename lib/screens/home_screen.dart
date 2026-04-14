name=lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/anime_provider.dart';
import '../widgets/hero_slider.dart';
import '../widgets/anime_card.dart';
import '../widgets/loading_shimmer.dart';
import '../theme/constants.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topAiring = ref.watch(topAiringProvider);
    final mostPopular = ref.watch(mostPopularProvider);
    final completed = ref.watch(completedProvider);

    return Scaffold(
      backgroundColor: AppColors.dark900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ZniWatch',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () => context.push('/library'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(topAiringProvider);
          ref.refresh(mostPopularProvider);
          ref.refresh(completedProvider);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Airing Hero Slider
              topAiring.when(
                data: (data) => HeroSlider(anime: data.take(5).toList()),
                loading: () => Container(
                  height: 300,
                  color: AppColors.dark700,
                ),
                error: (err, stack) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 24),

              // Most Popular Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Most Popular',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // View all popular
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    mostPopular.when(
                      data: (data) => SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.take(10).length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 130,
                              child: AnimeCard(
                                anime: data[index],
                                showTitle: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      loading: () => const LoadingShimmer(itemCount: 5),
                      error: (err, stack) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Completed Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    completed.when(
                      data: (data) => SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.take(10).length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 130,
                              child: AnimeCard(
                                anime: data[index],
                                showTitle: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      loading: () => const LoadingShimmer(itemCount: 5),
                      error: (err, stack) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
