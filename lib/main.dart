import 'core/app_theme.dart';
import 'features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;


import 'dart:io';
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostsBloc>()),
        ],
        child: MaterialApp(
          title: 'Material App',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: const PostsPage()
        ));
  }
}
