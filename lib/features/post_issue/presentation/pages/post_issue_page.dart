import 'dart:io';

import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:campus_saga/features/post_issue/presentation/cubit/post_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/image_picker.dart';
import '../../../../core/utils/random_picture.dart';
import '../../../../navigation/cubit/bottom_nav_cubit.dart';

class PostIssuePage extends StatefulWidget {
  const PostIssuePage({super.key});

  @override
  State<PostIssuePage> createState() => _PostIssuePageState();
}

class _PostIssuePageState extends State<PostIssuePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  void imagePicker() async {
    final pickedImage = await pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post an Issue")),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Post Issue Form",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Issue Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: null,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Issue Description',
                ),
              ),
              const SizedBox(height: 16),
              addPictrue(context),
              const SizedBox(height: 16),
              BlocConsumer<PostIssueCubit, PostIssueState>(
                listener: (context, state) {
                  if (state is PostIssueSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Issue Posted Successfully"),
                      ),
                    );
                    Navigator.popAndPushNamed(context, '/home');
                  }
                  if (state is PostIssueFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PostIssueLoading) {
                    return elevatedLoadingButton(context);
                  }
                  return elevatedButton(context);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  ElevatedButton elevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ignore: unused_local_variable
        final myUser = context.read<MyUserCubit>().state as MyUserLoggedIn;
        context.read<PostIssueCubit>().postIssue(
              _titleController.text.trim(),
              _descriptionController.text.trim(),
              myUser.user,
              _image,
            );
        // context.read<PostIssueCubit>().getIssue
        // ();
      },
      child: const Text("Post Issue"),
    );
  }

  ElevatedButton elevatedLoadingButton(BuildContext context) {
    return const ElevatedButton(
      onPressed: null,
      child: CircularProgressIndicator(),
    );
  }

  Widget addPictrue(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: imagePicker,
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: _image != null
                    ? FileImage(_image!)
                    : NetworkImage(randomPicture(10)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
