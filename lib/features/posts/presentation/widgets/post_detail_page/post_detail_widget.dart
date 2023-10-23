import '../../../../../core/util/snakbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/post.dart';
import '../../bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import '../../pages/post_add_update_page.dart';
import '../../pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_dialog_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(post.title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(height: 50),
          Text(post.body, style: const TextStyle(fontSize: 16)),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PostAddUpdatePage(
                                isUpdatePost: true,
                                post: post,
                              )));
                },
                icon: const Icon(Icons.edit),
                label: const Text("Update"),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () => deleteDialog(context),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostsBloc,
              AddDeleteUpdatePostsState>(builder: (context, state) {
            if (state is LoadingAddDeleteUpdateState) {
              return const AlertDialog(title: LoadingWidget());
            }

            return DeletDialogWidget(postId: post.id!);
          }, listener: (context, state) {
            if (state is MessageAddDeleteUpdateState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            } else if (state is ErrorAddDeleteUpdateState) {
              Navigator.of(context).pop();
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          });
        });
  }
}
