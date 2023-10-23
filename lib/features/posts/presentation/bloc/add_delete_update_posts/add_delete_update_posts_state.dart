part of 'add_delete_update_posts_bloc.dart';

sealed class AddDeleteUpdatePostsState extends Equatable {
  const AddDeleteUpdatePostsState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {}

class LoadingAddDeleteUpdateState extends AddDeleteUpdatePostsState {}

class ErrorAddDeleteUpdateState extends AddDeleteUpdatePostsState {
  final String message;

  const ErrorAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}


class MessageAddDeleteUpdateState extends AddDeleteUpdatePostsState {
  final String message;

  const MessageAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message]; 
}
