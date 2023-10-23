import 'core/network/network_info.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/posts_repositories.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/data/datasources/post_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feautres - posts

  // Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostsBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
