import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';
import 'package:zero_setup_flutter/app/router/routes.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFF27223D),
        // elevation: 5,
        foregroundColor: Colors.indigoAccent[100],
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Icon(LucideIcons.house400, size: 22), Gap(4), const Text('خانه')],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: const Center(
              child: Padding(padding: EdgeInsets.all(16.0), child: _Welcome()),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Sample Section',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue[800]),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.9,
              children: [
                _GridItem(
                  icon: Icons.dashboard,
                  title: 'normal',
                  color: Colors.blue,
                  onTap: () {
                    // context.goNamed(Routes.normalNotifier);
                    // context.push(Routes.normalNotifier);
                    // talker.good(Routes.normalNotifier);
                  },
                ),
                _GridItem(
                  icon: Icons.settings,
                  title: 'Async',
                  color: Colors.green,
                  onTap: () {
                    talker.good('Settings tapped');
                    // context.push(Routes.userProfile);
                  },
                ),
                _GridItem(
                  icon: Icons.person,
                  title: 'user_info',
                  color: Colors.orange,
                  onTap: () => context.push(Routes.exUserProfile),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Plugin Features',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.9,
              children: [
                _GridItem(
                  icon: Icons.map,
                  title: 'Map',
                  color: Colors.red,
                  onTap: () {
                    context.push(Routes.map);
                    talker.good('Map tapped');
                  },
                ),
                _GridItem(
                  icon: Icons.search,
                  title: 'Search',
                  color: Colors.purple,
                  onTap: () => talker.good('Search tapped'),
                ),
                _GridItem(
                  icon: Icons.favorite,
                  title: 'Favorites',
                  color: Colors.pink,
                  onTap: () => talker.good('Favorites tapped'),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 80), // Space for FAB
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to testing screen or add new feature
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 5),
        Text('به خانه خوش آمدید!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

        SizedBox(height: 2),
        Text(
          'این یک نمونه صفحه اصلی است.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.icon, required this.title, required this.color, required this.onTap});

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
