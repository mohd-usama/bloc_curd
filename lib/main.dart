import 'package:bloc_curd/screen/AddUser/AddUserBloc/add_user_bloc.dart';
import 'package:bloc_curd/screen/ShowUser/ShowUserBloc/show_user_bloc.dart';
import 'package:bloc_curd/splash_screeen.dart';
import 'package:bloc_curd/sqfliteHelper/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AddUserBloC()), BlocProvider(create: (_) => ShowUserBloc())],
      child: MaterialApp(
        title: 'SqfLite Bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreeen(),
      ),
    );
  }
}
