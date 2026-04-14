name=lib/screens/episode_selector_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/anime_provider.dart';
import '../providers/episode_provider.dart';
import '../theme/constants.dart';

final selectedAudioProvider = StateProvider<String>((ref) => 'sub');

class EpisodeSelectorScreen extends ConsumerWidget {
  final String animeId;

  const EpisodeSelectorScreen({Key? key, required this.animeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final episodesData = ref.watch(episodesProvider(animeId));
    final animeDetail = ref.watch(animeDetailsProvider(animeId));
    final selectedAudio = ref.watch(selectedAudioProvider);

    return Scaffold(
      backgroundColor: AppColors.dark900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Episodes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(selectedAudioProvider.notifier).state =
                          'sub';
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedAudio == 'sub'
                            ? AppColors.primary
                            : AppColors.dark700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('SUB'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(selectedAudioProvider.notifier).state =
                          'dub';
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedAudio == 'dub'
                            ? AppColors.primary
                            : AppColors.dark700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('DUB'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: episodesData.when(
              data: (episodes) => GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: episodes.episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes.episodes[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/watch/$animeId?epId=${episode.id}&ep=${episode.episodeNumber}&audio=$selectedAudio',
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.dark700,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primary
                              .withOpacity(0.3),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              'EP',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '${episode.episodeNumber}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (episode.isFiller)
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 4),
                                padding: const EdgeInsets
                                    .symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius:
                                      BorderRadius
                                          .circular(4),
                                ),
                                child: const Text(
                                  'Filler',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(
                    color: AppColors.primary),
              ),
              error: (err, stack) => Center(
                child: Text('Error: $err'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
