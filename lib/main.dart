import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_demo/config/routes.dart';
import 'package:reels_demo/config/theme.dart';
import 'package:reels_demo/features/reels/data/data_srource/local_datasource/database_helper.dart';
import 'package:reels_demo/features/reels/presentation/cubit/reels_cubit.dart';

import 'utils/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initializeDatabase();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<ReelsCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Reels Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: Routes.router,
      ),
    );
  }
}
