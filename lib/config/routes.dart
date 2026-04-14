name=lib/config/routes.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/anime_details_screen.dart';
import '../screens/episode_selector_screen.dart';
import '../screens/video_player_screen.dart';
import '../screens/library_screen.dart';
import '../screens/dubbed_anime_screen.dart';

final goRouterProvider = Provider((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/library',
        builder: (context, state) => const LibraryScreen(),
      ),
      GoRoute(
        path: '/dubbed',
        builder: (context, state) => const DubbedAnimeScreen(),
      ),
      GoRoute(
        path: '/anime/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AnimeDetailsScreen(animeId: id);
        },
      ),
      GoRoute(
        path: '/anime/:id/episodes',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EpisodeSelectorScreen(animeId: id);
        },
      ),
      GoRoute(
        path: '/watch/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final epId = state.uri.queryParameters['epId'] ?? '';
          final ep = int.tryParse(state.uri.queryParameters['ep'] ?? '1') ?? 1;
          final audio = state.uri.queryParameters['audio'] ?? 'sub';
          return VideoPlayerScreen(
            animeId: id,
            episodeId: epId,
            episodeNumber: ep,
            audioType: audio,
          );
        },
      ),
    ],
  );
});
