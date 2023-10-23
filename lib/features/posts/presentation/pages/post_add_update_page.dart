import '../bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snakbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child:
            BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsState>(
                builder: (context, state) {
          if (state is LoadingAddDeleteUpdateState) {
            return const LoadingWidget();
          }
          return FormWidget(
              isUpdatePost: isUpdatePost, posts: isUpdatePost ? post : null);
        }, listener: (context, state) {
          if (state is MessageAddDeleteUpdateState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (route) => false);
          } else if (state is ErrorAddDeleteUpdateState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        }),
      ),
    );
  }
}
