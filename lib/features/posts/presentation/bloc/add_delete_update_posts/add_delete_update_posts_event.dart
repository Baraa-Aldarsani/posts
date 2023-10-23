part of 'add_delete_update_posts_bloc.dart';

sealed class AddDeleteUpdatePostsEvent extends Equatable {
  const AddDeleteUpdatePostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  const AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  const UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostsEvent{
  final int postId;

  const DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
