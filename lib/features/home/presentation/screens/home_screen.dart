import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../../../../shared/domain/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('خانه'), backgroundColor: Colors.blueGrey),
      body: ListView.builder(
        primary: true,
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.lightBlueAccent[100],
            contentPadding: EdgeInsets.all(5),
            // visualDensity: VisualDensity.compact,
            shape: Border.symmetric(horizontal: BorderSide(color: Colors.white, width: 2)),
            title: Text('data'),
            onTap: () {},
            dense: true,
            style: ListTileStyle.list,
            horizontalTitleGap: 4,
          );
        },
      ),
    );
  }
}
