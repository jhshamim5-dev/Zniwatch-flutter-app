name=lib/screens/dubbed_anime_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/constants.dart';

class DubbedAnimeScreen extends ConsumerWidget {
  const DubbedAnimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.dark900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Dubbed Anime'),
      ),
      body: const Center(
        child: Text('Dubbed Anime Coming Soon'),
      ),
    );
  }
}
