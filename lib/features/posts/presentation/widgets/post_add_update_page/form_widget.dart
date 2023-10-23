import '../../bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget(
      {super.key, required this.isUpdatePost, this.post, Post? posts});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              name: " Title", multiLine: false, controller: _titleController),
          TextFormFieldWidget(
              name: " Body", multiLine: true, controller: _bodyController),
          FormSubmitBtn(
              isUpdatePost: widget.isUpdatePost,
              onPressed: validateFormThenUpdateOrAddPost),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
