name=lib/screens/anime_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/anime_provider.dart';
import '../providers/watch_history_provider.dart';
import '../models/watch_history_model.dart';
import '../theme/constants.dart';

class AnimeDetailsScreen extends ConsumerWidget {
  final String animeId;

  const AnimeDetailsScreen({Key? key, required this.animeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeDetail = ref.watch(animeDetailsProvider(animeId));
    final isInWatchlist = ref.watch(
      watchlistNotifierProvider.select(
        (list) => list.any((entry) => entry.animeId == animeId),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.dark900,
      body: animeDetail.when(
        data: (anime) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          anime.bannerUrl ?? anime.posterUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.dark900.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      if (isInWatchlist) {
                        ref
                            .read(watchlistNotifierProvider.notifier)
                            .removeFromWatchlist(animeId);
                      } else {
                        ref
                            .read(watchlistNotifierProvider.notifier)
                            .addToWatchlist(
                              WatchlistEntry(
                                animeId: animeId,
                                animeTitle: anime.title,
                                animeCover: anime.posterUrl,
                                totalEpisodes: anime.episodes ?? 0,
                                addedAt:
                                    DateTime.now()
                                        .millisecondsSinceEpoch,
                              ),
                            );
                      }
                    },
                    child: Icon(
                      isInWatchlist
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: isInWatchlist
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (anime.japaneseTitle != null)
                      Text(
                        anime.japaneseTitle!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (anime.averageScore != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                                  BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${(anime.averageScore! / 10).toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                          child: Text(
                            anime.status,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (anime.description != null)
                      Text(
                        anime.description!,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    const SizedBox(height: 24),
                    if (anime.genres.isNotEmpty)
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Genres',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: anime.genres
                                .map(
                                  (genre) => Container(
                                    padding: const EdgeInsets
                                        .symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey
                                              .shade800,
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        20,
                                      ),
                                    ),
                                    child: Text(
                                      genre,
                                      style:
                                          const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child:
              CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(
          child: Text('Error: $err'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/anime/$animeId/episodes'),
        label: const Text('Watch Now'),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
