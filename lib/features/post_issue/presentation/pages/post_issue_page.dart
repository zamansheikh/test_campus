import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:campus_saga/features/post_issue/presentation/cubit/post_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostIssuePage extends StatefulWidget {
  const PostIssuePage({super.key});

  @override
  State<PostIssuePage> createState() => _PostIssuePageState();
}

class _PostIssuePageState extends State<PostIssuePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post an Issue")),
      body: Center(
          child: Column(
        children: [
          const Text("Post Issue Form"),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Issue Title',
            ),
          ),
          TextField(
            maxLines: null,
            controller: _descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Issue Description',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // ignore: unused_local_variable
              final myUser =
                  context.read<MyUserCubit>().state as MyUserLoggedIn;
              context.read<PostIssueCubit>().postIssue(
                    _titleController.text.trim(),
                    _descriptionController.text.trim(),
                    myUser.user,
                  );
              // context.read<PostIssueCubit>().getIssue
              // ();
            },
            child: const Text("Post Issue"),
          ),
        ],
      )),
    );
  }
}
