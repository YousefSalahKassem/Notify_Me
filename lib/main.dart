import 'package:bloctest/blocs/groups/group_cubit.dart';
import 'package:bloctest/blocs/tasks/task_cubit.dart';
import 'package:bloctest/ui/screens/boarding/on_boarding_screen.dart';
import 'package:bloctest/ui/screens/boarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/globals.dart';
import 'helper/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupBloc>(
          create: (context) => GroupBloc()..initDatabase(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc()..initDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: Globals.instance.navigatorKey,
        onGenerateRoute: (settings) => AppRoute.onGenerateRoutes(settings),
        home: const SplashScreen(),
      ),
    );
  }
}
