// lib/app/app.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persian_fonts/persian_fonts.dart';

import 'router/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Enterprise App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: PersianFonts.vazirTextTheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.light),
        useMaterial3: true,
        fontFamily: 'Vazirmatn', // اگه فونت فارسی داری
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigoAccent,
          brightness: Brightness.dark,
          surface: Color.fromARGB(255, 10, 8, 14),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1C1530)),
        textTheme: PersianFonts.vazirTextTheme,
        useMaterial3: true,
        fontFamily: 'Vazirmatn',
      ),
      themeMode: ThemeMode.dark,
      routerConfig: router,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // برای فارسی
          child: child!,
        );
      },
    );
  }
}
