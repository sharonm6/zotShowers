import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zotshowers/home_screen.dart';
import 'package:zotshowers/logic.dart';
import 'package:zotshowers/shop_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'shop',
            builder: (BuildContext context, GoRouterState state) {
              return const ShopScreen();
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserDataCubit(),
      child: MaterialApp.router(
        theme: ThemeData(
          fontFamily: "Soleil",
        ),
        routerConfig: _router,
      ),
    );
  }
}
