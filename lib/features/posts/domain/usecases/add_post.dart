import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repositories.dart';

class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
